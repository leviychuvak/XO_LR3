using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.ServiceRuntime;
using Microsoft.WindowsAzure.StorageClient;
using System.Configuration;
using System.Collections.Specialized;


namespace AzureBlobSamle
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    this.EnsureContainerExists();
                }
                this.RefreshGallery();
            }
            catch (System.Net.WebException we)
            {
                lb_status.Text = "Network error: " + we.Message;
                if (we.Status == System.Net.WebExceptionStatus.ConnectFailure)
                {
                    lb_status.Text += "<br />Please check if the blob service is running at " +
                    ConfigurationManager.AppSettings["storageEndpoint"];
                }
            }
            catch (StorageException se)
            {
                Console.WriteLine("Storage service error: " + se.Message);
            }

        }

        private void RefreshGallery()
        {
            lv_images.DataSource =
              this.GetContainer().ListBlobs(new BlobRequestOptions()
              {
                  UseFlatBlobListing = true,
                  BlobListingDetails = BlobListingDetails.All
              });
            lv_images.DataBind();
        }

        private CloudBlobContainer GetContainer()
        {
            CloudStorageAccount.SetConfigurationSettingPublisher(
                (configName, configSettingPublisher) =>
                {
                    var connectionString =
                        RoleEnvironment.GetConfigurationSettingValue(configName);
                    configSettingPublisher(connectionString);
                }
            );

            var account = CloudStorageAccount.FromConfigurationSetting("DataConnectionString");
            var client = account.CreateCloudBlobClient();
            return client.GetContainerReference(RoleEnvironment.GetConfigurationSettingValue("ContainerName"));
        }

        private void EnsureContainerExists()
        {
            var container = GetContainer();
            container.CreateIfNotExist();
            var permissions = container.GetPermissions();
            permissions.PublicAccess = BlobContainerPublicAccessType.Container;
            container.SetPermissions(permissions);
        }

        private void SaveImage(string id, string name, string description, string fileName, string contentType, byte[] data)
        {
            var blob = this.GetContainer().GetBlobReference(name);
            blob.Properties.ContentType = contentType;

            try
            {
                blob.UploadFromStream(fu_upload.FileContent);
                blob.Metadata["Id"] = id;
                blob.Metadata["Filename"] = fileName;
                blob.Metadata["ImageName"] = String.IsNullOrEmpty(name) ? "unknown" : name;
                blob.Metadata["Description"] = String.IsNullOrEmpty(description) ? "unknown" : description;
                blob.SetMetadata();
                lv_images.DataBind();
            }
            catch (Exception ex)
            { lb_status.Text = ex.Message; }
        }

        protected void btn_upload_Click(object sender, EventArgs e)
        {
            if (fu_upload.HasFile)
            {
                lb_status.Text = "Inserted [" + fu_upload.FileName + "] - Content Type [" +
                fu_upload.PostedFile.ContentType + "] - Length [" + fu_upload.PostedFile.ContentLength + "]";
                this.SaveImage(Guid.NewGuid().ToString(),
                  tb_name.Text,
                  tb_desc.Text,
                  fu_upload.FileName,
                  fu_upload.PostedFile.ContentType,
                  fu_upload.FileBytes
                );
                RefreshGallery();
            }
            else
                lb_status.Text = "No image file";
        }

        protected void lv_images_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                var metadataRepeater = e.Item.FindControl("blobMetadata") as Repeater;
                var blob = ((ListViewDataItem)(e.Item)).DataItem as CloudBlob;
                if (blob != null)
                {
                    if (blob.SnapshotTime.HasValue)
                    {
                        var delBtn = e.Item.FindControl("deleteBlob") as LinkButton;
                        if (delBtn != null) delBtn.Text = "Delete Snapshot";
                        var snapshotBtn = e.Item.FindControl("SnapshotBlob") as LinkButton;
                        if (snapshotBtn != null) snapshotBtn.Visible = false;
                    }
                    if (metadataRepeater != null)
                    {
                        metadataRepeater.DataSource = from key in blob.Metadata.AllKeys
                                                      select new
                                                      {
                                                          Name = key,
                                                          Value = blob.Metadata[key]
                                                      };
                        metadataRepeater.DataBind();
                    }
                }
            }
        }

        protected void OnDeleteImage(object sender, CommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "Delete")
                {
                    var blobUri = (string)e.CommandArgument;
                    var blob = this.GetContainer().GetBlobReference(blobUri);
                    blob.DeleteIfExists();
                }
            }
            catch (StorageClientException se)
            {
                lb_status.Text = "Storage client error: " + se.Message;
            }
            catch (Exception) { }
            RefreshGallery();
        }


        protected void OnCopyImage(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Copy")
            {
                // Prepare an Id for the copied blob
                var newId = Guid.NewGuid();
                // получение исходного объекта
                var blobUri = (string)e.CommandArgument;
                var srcBlob = this.GetContainer().GetBlobReference(blobUri);
                // создание нового бинарного объекта
                var newBlob = this.GetContainer().GetBlobReference(newId.ToString());
                // копирование содержимого исходного объекта
                newBlob.CopyFromBlob(srcBlob);
                // получаем метаданные для нового объекта
                newBlob.FetchAttributes(new BlobRequestOptions { BlobListingDetails = BlobListingDetails.Metadata });
                // изменение метаданных нового объекта, чтобы показать, что это копия
                newBlob.Metadata["ImageName"] = "Copy of \"" +
                  newBlob.Metadata["ImageName"] + "\"";
                newBlob.Metadata["Id"] = newId.ToString();
                newBlob.SetMetadata();
                RefreshGallery();
            }
        }

        protected void OnSnapshotImage(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Snapshot")
{
                // Get source blob
                var blobUri = (string)e.CommandArgument;
                var srcBlob = this.GetContainer().GetBlobReference(blobUri);
                // Create a snapshot
                var snapshot = srcBlob.CreateSnapshot();
                lb_status.Text = " A snapshot has been taken for image blob:" +srcBlob.Uri + " at " +
                 snapshot.SnapshotTime;
                RefreshGallery();
            }
        }

    }



}
