Set-ExecutionPolicy RemoteSigned

# Import NAVadmin-module 
Import-Module 'C:\Program Files\Microsoft Dynamics 365 Business Central\140\Service\NavAdminTool.ps1'

$ServerInstance = "BC140"
$Tenant = "default"
$ExtensionName = "NAVSPC - Immudex"
$ExtensionVersion = "1.2022.0.0"
$ExtensionFilename = "C:\NAV BC Installation\Project\NAVspecialist\AL\IMU_NAVSPC\NAVSpecialist ApS_NAVSPC - Immudex_1.2022.0.0.app"


Get-NAVAppInfo -ServerInstance $serverInstance
Get-NAVAppRuntimePackage -ServerInstance $ServerInstance -Tenant $Tenant -Name '52BC Immudex' -Version "1.0.0.0" -Path "C:\NAV BC Installation\Project\IMU\AL\IMU\fiftytwo_52BC Immudex_1.0.0.0.app"  

Publish-NAVApp -ServerInstance $ServerInstance -Path $ExtensionFilename -SkipVerification -Force -verbose


Sync-Navapp - -ServerInstance $serverInstance -Name $extensionName
Install-NAVApp -ServerInstance $serverInstance -Name $extensionName -Version $extensionVersion -Skipverification -Tenant $Tenant


# ***********************************************
# *            Installation af Zebon            *
# ***********************************************

# publish-navapp -serverinstance BC140 -path ".\Agidon_AS_Zebon_1.0.0.10.app" -skipverification
# Sync-navapp -serverinstance BC140 -name "Zebon"
# install-navapp -serverinstance BC140 -name "Zebon"
