<#
.SYNOPSIS
    Automated File Sorter - Organizador de Arquivos por Extensão.

.DESCRIPTION
    Script destinado à manutenção de estações de trabalho.
    Varre um diretório especificado, identifica tipos de arquivos e os organiza
    em pastas temáticas.

.NOTES
    Ideal para limpeza de pastas de Downloads ou diretórios de Logs.

.AUTHOR
    Enchanted
#>
# ===============================================
#              Ferramentas Visuais
# ===============================================
function Write-Center {
    param(
        [string]$Texto,
        [ConsoleColor]$Cor = "Cyan", 
        [ConsoleColor]$Cor2 = "Green",
        [ConsoleColor]$Fundo = "Black" 
    )

    $LarguraJanela = $Host.UI.RawUI.WindowSize.Width
    
    
    $EspacosEsquerda = [math]::Max(0, [int](($LarguraJanela - $Texto.Length) / 2))
    

    $TextoCentralizado = (" " * $EspacosEsquerda) + $Texto

    Write-Host $TextoCentralizado -ForegroundColor $Cor -BackgroundColor $Fundo
}
function Push-ToCenter {
    param(
        [int]$TamanhoDoMenu = 12 # Chutei que seu menu ocupa 12 linhas
    )

    # 1. Mede a altura da janela
    $AlturaJanela = $Host.UI.RawUI.WindowSize.Height
    
    # 2. Calcula quantas linhas vazias precisa pular no topo
    # O [math]::Max impede erro se a tela for muito pequena
    $EspacosTopo = [math]::Max(0, [int](($AlturaJanela - $TamanhoDoMenu) / 2))
    
    # 3. Dá os "Enters" necessários
    for ($i = 0; $i -lt $EspacosTopo; $i++) {
        Write-Host ""
    }
}
function Read-Center {
    param(
        [string]$Mensagem
    )
    $LarguraJanela = $Host.UI.RawUI.WindowSize.Width
    
    $EspacosEsquerda = [math]::Max(0, [int](($LarguraJanela - $Mensagem.Length) / 2))
    
    $Margem = " " * $EspacosEsquerda
    
    return Read-Host "$Margem$Mensagem"
}
# ==========================================
#       ÁREA DE FUNÇÕES (FERRAMENTAS)
# ==========================================

function AccessDownloadFolder {
    Write-Center ""
    Write-Center "=====================================" -ForegroundColor Cyan
    Write-Center "    Accessing Downloads Folders...   " -ForegroundColor Cyan
    Write-Center "=====================================" -ForegroundColor Cyan
    Write-Center ""
    Start-Sleep -Seconds 1

    Write-Center "Organizing all the Files..." -ForegroundColor Cyan
    Start-Sleep -Seconds 1

    $FolderOrganizer = Get-ChildItem -Path $HOME\Downloads -File 
    
    foreach ($ArquivoUnico in $FolderOrganizer) {
        
        $PathFolder = ""
        
        # Lógica para separar imagens
        if ($ArquivoUnico.Extension -in @(".jpg", ".png", ".jpeg", ".gif", ".bmp", ".webp")){
            $PathFolder = "$Home\Pictures\Folder$($ArquivoUnico.Extension)"
        } else {
            $PathFolder = "$Home\Downloads\Folder$($ArquivoUnico.Extension)"
        }

        # Verifica e cria pasta se necessário
        if (-not (Test-Path $PathFolder)) {
            Write-Center ""
            Write-Center "Creating New Folder: $PathFolder" -ForegroundColor Yellow
            Start-Sleep -Seconds 1
            New-Item -Path $PathFolder -ItemType Directory -Force | Out-Null
        }
        Write-Center ""
        Write-Center "Processing: $($ArquivoUnico.Name)" -ForegroundColor Gray
        Start-Sleep -Seconds 1
        Move-Item -Path $ArquivoUnico.FullName -Destination $PathFolder   
    }
    
    Write-Center ""
    Write-Center "Organization Completed!" -ForegroundColor Green
    Write-Center ""
}

function CleanTempFiles {
    Write-Center ""
    Write-Center "Accessing Temp Files..." -ForegroundColor Yellow
    Start-Sleep -Seconds 1
    # Sua lógica de limpeza virá aqui.
    # Por enquanto, mantive o que você escreveu:
    $FileCleaner = Get-ChildItem -Path $env:TEMP -File -Recurse -ErrorAction SilentlyContinue
    
    if ($FileCleaner) {
    Write-Center ""
    Write-Center "Found $($FileCleaner.Count) files in Temp." -ForegroundColor Cyan 
    Write-Center ""
    Start-Sleep -Seconds 1
    Write-Center "Cleaning Now..." -ForegroundColor Cyan 
    Start-Sleep -Seconds 1
    }else{
    Write-Center "Temp folder is mostly clean or locked." -ForegroundColor Gray
    }
   
    remove-item -Path $env:temp -Recurse -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 1
    Write-Center ""
    Write-Center "Cleanup finished! (Locked files were skipped)" -ForegroundColor Green
    Write-Center ""

}

# ==========================================
# EXECUÇÃO PRINCIPAL (MENU)
# ==========================================

$Sair = $False 

do {
    Clear-Host

    Push-ToCenter -TamanhoDoMenu 12

    Write-Center "=========================================" -ForegroundColor Cyan
    Write-Center "       File Organizer/File Cleaner       " -ForegroundColor Cyan
    Write-Center "=========================================" -ForegroundColor Cyan
    Write-Center ""
    Write-Center "  1. Organize Files (Downloads)            "
    Write-Center "  2. Clean Files (%Temp%)                  "
    Write-Center "  3. Exit                                  "
    Write-Center "-----------------------------------------"
    Write-Center ""
    
    $Opcao = Read-Center " Choose an Option "   

    switch ($Opcao) {
        "1" { 
            AccessDownloadFolder
            Read-Center "Press ENTER to return to the menu..." 
        }
        "2" { 
            CleanTempFiles
            Read-Center "Press ENTER to return to the menu..." 
        }
        "3" { 
            Write-Center ""
            Write-Center "Closing..." -ForegroundColor Red
            Start-Sleep -Seconds 1
            $Sair = $True 
        }
        Default { 
            Write-Center "Invalid Option!" -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }

} until ($Sair -eq $True)