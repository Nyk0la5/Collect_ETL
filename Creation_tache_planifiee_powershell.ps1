# Création d'une tâche planifiée pour lister l'ensemble des fichiers ".etl" dans le fichier texte "list_file_etl.txt" et les copier dans le dossier nommé "ETL"
# Nicolas CARPENTIER
# avril 2021
# version 1
# testé sur version powershell 5 et environnement windows 10 familiale
# Exécution de Powershell en tant qu'administrateur

# Déclaration des variables utilisées pour la tâche planifiée :
# Récupération de la lecteur de lecteur où l'OS est installé
$LetterOS= (Get-WmiObject Win32_OperatingSystem).SystemDrive
$SourceDir= "$LetterOS\"
cd $SourceDir
# Dénomination du dossier de collectes
$TargetDir= 'ETL'
# Attribution d'un nom à la tâche planifiée
$TaskName= "List_file_ETL"
# Attribution d'une description de la tâche planifiée
$Description= "Lister l'ensemble des fichiers .etl presents sur la machine hote et les copier"
# Création du déclencheur (juste parce qu'il faille en définir un)
$Trigger= New-ScheduledTaskTrigger -At 10:00 -Once
# Identité du compte utilisateur qui sera utilisé
$User= "NT AUTHORITY\SYSTEM"
# Création du dossier nommé "ETL" afin de recevoir les éléments collectés
$Act1= New-ScheduledTaskAction -Execute "powershell.exe" -Argument "New-Item -Path $SourceDir -Name $TargetDir -ItemType directory"
# Création du fichier nommé "List_file_etl.txt" sous "C:\ETL"
$Act2= New-ScheduledTaskAction -Execute "powershell.exe" -Argument "Get-ChildItem $SourceDir -Filter *.etl -Recurse | Out-File $SourceDir$TargetDir\List_file_etl.txt"
# Copie des fichiers ".etl" sous "C:\ETL\" en conservant l'arborescence des fichiers trouvés
$Act3= New-ScheduledTaskAction -Execute "powershell.exe" "-Command Get-ChildItem -Path $SourceDir -Recurse -Include *.etl | `
	    foreach{
		$targetFile= $TargetDir\ + $_.FullName.SubString($SourceDir.Length);
        New-Item -ItemType File -Path $targetFile -Force;
        Copy-Item $_.FullName -destination $targetFile
    }"

# Création de la tâche planifiée :
Register-ScheduledTask -TaskName $TaskName -Description $Description -Trigger $Trigger -User $User -Action $Act1,$Act2,$Act3 -RunLevel Highest -Force

# Exécution de la tâche planifiée maintenant :
Start-ScheduledTask -TaskName $TaskName
