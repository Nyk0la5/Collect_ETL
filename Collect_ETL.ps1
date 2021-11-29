# Script pour lister l'ensemble des fichiers ".etl" dans un fichier texte nommé "list_file_etl.txt" et copier les fichiers "*.etl" dans un dossier nommé "ETL_$ComputerName" en conversant l’arborescence récursive des dossiers dans lesquels les fichiers ".etl" ont été trouvés.
# CALID – SAS
# ADJ CARPENTIER
# avril 2021
# version 1
# testé sur version powershell 5 et environnement windows 10 familial et professionnel


# Récupération de la lettre du lecteur où l'OS est installé en tant que variable et déplacement à la racine de cette même lettre
$LetterOS= (Get-WmiObject Win32_OperatingSystem).SystemDrive
$SourceDir= "$LetterOS\"
cd $SourceDir

# Dénomination du dossier de collecte
$ComputerName= hostname
$TargetDir= "ETL_$ComputerName"

# Création du dossier nommé "ETL_$ComputerName" afin de recevoir les éléments collectés
New-Item -Path $SourceDir -Name $TargetDir -ItemType directory

# Création du fichier nommé "List_files_etl.txt" sous "$SourceDir:\ETL_$ComputerName" qui contiendra la liste des fichiers ".etl" trouvés et leurs emplacements avant copie
Get-ChildItem $SourceDir -Filter *.etl -Recurse | Out-File $SourceDir$TargetDir\List_files_etl.txt

# Copie des fichiers ".etl" sous "$SourceDir:\ETL_$ComputerName\" en conservant l'arborescence récursive des dossiers dans lesquels les fichiers ".etl" ont été trouvés
Get-ChildItem -Path $SourceDir -Recurse -Include *.etl | `
    foreach{
        $targetFile = "$TargetDir\" + $_.FullName.SubString($SourceDir.Length);
        New-Item -ItemType File -Path $targetFile -Force;
        Copy-Item $_.FullName -destination $targetFile
    }
