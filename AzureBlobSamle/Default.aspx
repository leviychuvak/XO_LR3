<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AzureBlobSamle._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
   <div> 
      
         <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="X-Large"  
             Text="My Image Gallery - Azure Blob Example"></asp:Label> 
         <br /> 
         <br /> 
         <table style="width:100%;"> 
             <tr> 
                 <td> 
                     <asp:Label ID="lb_name" runat="server" Text="Название"></asp:Label> 
                 </td> 
                 <td> 
                     <asp:TextBox ID="tb_name" runat="server"></asp:TextBox> 
                 </td> 
             </tr> 
             <tr> 
                 <td> 
                     <asp:Label ID="lb_desc" runat="server" Text="Описание"></asp:Label> 
                 </td> 
                 <td> 
                     <asp:TextBox ID="tb_desc" runat="server"></asp:TextBox> 
                 </td> 
             </tr> 
             <tr> 
                 <td> 
                      </td> 
                 <td> 
                      </td> 
             </tr> 
             <tr> 
                 <td class="style1"> 
                     <asp:Label ID="lb_file" runat="server" Text="Файл"></asp:Label> 
                 </td> 
                 <td class="style1"> 
                     <asp:FileUpload ID="fu_upload" runat="server" /> 
                 </td> 
             </tr> 
             <tr> 
                 <td> 
                      </td> 
                 <td> 
                     <asp:Button ID="btn_upload" runat="server" onclick="btn_upload_Click"  
                         Text="Загрузить" /> 
                 </td> 
             </tr> 
             <tr> 
                 <td> 
                     &nbsp;</td> 
                 <td> 
                     <asp:Label ID="lb_status" runat="server"></asp:Label> 
                      </td> 
             </tr> 
             <tr> 
                 <td> 
                      </td> 
                 <td> 
                     <asp:ListView ID="lv_images" runat="server"  
                         onitemdatabound="lv_images_ItemDataBound"> 
             <LayoutTemplate> 
                 <asp:PlaceHolder ID="itemPlaceholder" runat="server" /> 
             </LayoutTemplate> 
             <EmptyDataTemplate> 
                 <h2>No Data Available</h2> 
             </EmptyDataTemplate> 
             <ItemTemplate>             
                 <div class="item"> 
                     <ul style="width:40em;float:left;clear:left" > 
                         <asp:Repeater ID="blobMetadata" runat="server"> 
                         <ItemTemplate> 
                             <li><%# Eval("Name") %><span><%# Eval("Value") %></span></li> 
                         </ItemTemplate> 
                         </asp:Repeater> 
                         <li> 
                             <asp:LinkButton ID="deleteBlob"  
                                     OnClientClick="return confirm('Delete image?');" 
                                     CommandName="Delete"  
                                     CommandArgument='<%# Eval("Uri")%>' 
                                     runat="server" Text="Удалить" oncommand="OnDeleteImage" /> 
  
                             <asp:LinkButton ID="CopyBlob"  
                                     OnClientClick="return confirm('Copy image?');" 
                                     CommandName="Copy"  
                                     CommandArgument='<%# Eval("Uri")%>' 
                                     runat="server" Text="Копировать" oncommand="OnCopyImage" /> 
                             <asp:LinkButton ID="SnapshotBlob"
                                    OnClientClick="return confirm('Snapshot image?');"
                                    CommandName="Snapshot"
                                    CommandArgument='<%# Eval("Uri")%>'
                                    runat="server" Text="Snapshot" oncommand="OnSnapshotImage" />
  
                         </li> 
                     </ul> 
                     <img src="<%# Eval("Uri") %>" alt="<%# Eval("Uri") %>" style="float:left"/> 
                 </div> 
             </ItemTemplate> 
         </asp:ListView> 
  
                     </td> 
             </tr> 
             <tr> 
                 <td> 
  
                     <br /> 
                 </td> 
                 <td> 
                      </td> 
             </tr> 
         </table> 
      
     </div> 


</asp:Content>
