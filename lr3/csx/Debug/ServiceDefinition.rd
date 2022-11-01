<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" name="lr3" generation="1" functional="0" release="0" Id="e93ee05a-817e-4c6c-acbc-53b980014b41" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="lr3Group" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="AzureBlobSamle:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/lr3/lr3Group/LB:AzureBlobSamle:Endpoint1" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="AzureBlobSamle:ContainerName" defaultValue="">
          <maps>
            <mapMoniker name="/lr3/lr3Group/MapAzureBlobSamle:ContainerName" />
          </maps>
        </aCS>
        <aCS name="AzureBlobSamle:DataConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/lr3/lr3Group/MapAzureBlobSamle:DataConnectionString" />
          </maps>
        </aCS>
        <aCS name="AzureBlobSamle:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/lr3/lr3Group/MapAzureBlobSamle:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="AzureBlobSamleInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/lr3/lr3Group/MapAzureBlobSamleInstances" />
          </maps>
        </aCS>
      </settings>
      <channels>
        <lBChannel name="LB:AzureBlobSamle:Endpoint1">
          <toPorts>
            <inPortMoniker name="/lr3/lr3Group/AzureBlobSamle/Endpoint1" />
          </toPorts>
        </lBChannel>
      </channels>
      <maps>
        <map name="MapAzureBlobSamle:ContainerName" kind="Identity">
          <setting>
            <aCSMoniker name="/lr3/lr3Group/AzureBlobSamle/ContainerName" />
          </setting>
        </map>
        <map name="MapAzureBlobSamle:DataConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/lr3/lr3Group/AzureBlobSamle/DataConnectionString" />
          </setting>
        </map>
        <map name="MapAzureBlobSamle:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/lr3/lr3Group/AzureBlobSamle/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapAzureBlobSamleInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/lr3/lr3Group/AzureBlobSamleInstances" />
          </setting>
        </map>
      </maps>
      <components>
        <groupHascomponents>
          <role name="AzureBlobSamle" generation="1" functional="0" release="0" software="D:\Fourth\sem 1\XO\LR3\lr3\lr3\csx\Debug\roles\AzureBlobSamle" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaIISHost.exe " memIndex="-1" hostingEnvironment="frontendadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Endpoint1" protocol="http" portRanges="80" />
            </componentports>
            <settings>
              <aCS name="ContainerName" defaultValue="" />
              <aCS name="DataConnectionString" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;AzureBlobSamle&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;AzureBlobSamle&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/lr3/lr3Group/AzureBlobSamleInstances" />
            <sCSPolicyUpdateDomainMoniker name="/lr3/lr3Group/AzureBlobSamleUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/lr3/lr3Group/AzureBlobSamleFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
      </components>
      <sCSPolicy>
        <sCSPolicyUpdateDomain name="AzureBlobSamleUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyFaultDomain name="AzureBlobSamleFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyID name="AzureBlobSamleInstances" defaultPolicy="[1,1,1]" />
      </sCSPolicy>
    </group>
  </groups>
  <implements>
    <implementation Id="c7d4b335-a050-4a20-b420-0b4a6bbc5f16" ref="Microsoft.RedDog.Contract\ServiceContract\lr3Contract@ServiceDefinition">
      <interfacereferences>
        <interfaceReference Id="b2498c77-a4c4-45a8-8829-9848e8910abe" ref="Microsoft.RedDog.Contract\Interface\AzureBlobSamle:Endpoint1@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/lr3/lr3Group/AzureBlobSamle:Endpoint1" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>