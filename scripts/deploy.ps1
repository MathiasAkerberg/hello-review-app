[CmdletBinding()]
param( 
    [Parameter(Mandatory = $true)]
    [string] $Kustomization,

    [Parameter(Mandatory = $false)]
    [string] $Namespace,

    [Parameter(Mandatory = $true)]
    [string] $Deployment
)

function Deploy() {
    [CmdletBinding()]
    param( 
        [Parameter(Mandatory = $true)]
        [string] $Kustomization,

        [Parameter(Mandatory = $false)]
        [string] $Namespace,
    
        [Parameter(Mandatory = $true)]
        [string] $Deployment
    )

    If ([string]::IsNullOrEmpty($Namespace) -eq $false) {
        $Namespace = "-n $Namespace"
    }

    Write-Host "Deploying Kustomization '$Kustomization'..."
    kubectl kustomize $Kustomization | kubectl $Namespace apply -f -

    Write-Host "Waiting for deployment..."
    kubectl $Namespace rollout status "deployment.apps/$Deployment"
}
        
Deploy -Kustomization $Kustomization -Namespace $Namespace -Deployment $Deployment