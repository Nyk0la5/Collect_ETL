**README**

# Collect_ETL
Ce projet a pour but de partager un script PowerShell de collecte des fichiers ETL sous environnement Windows.   
## 1. La collecte en live des fichiers « .etl » nécessite en premier lieu la récupération de deux outils :
•	l’outil « **_PsExec64.exe_** » de la suite « _SystinternalsSuite_ » ;  
•	le script « **_Collect_ETL.ps1_** ».

A propos de « **_PsExec64.exe_** » :
Cet outil libre de droit, est téléchargeable depuis le site Microsoft via le lien suivant :  
« https://download.sysinternals.com/files/SysinternalsSuite.zip) ».  
SHA-1 de « **_PsExec64.exe_** » : « **6c79d9ca8bf0a3b5f04d317165f48d4eedd04d40** ».  
Ce soft permettra notamment d'obtenir les droits utilisateur « **_AUTORITÉ NT / Système_** » nécessaires à la suite des opérations.  
Dans l’exemple présenté, on considère enregistrer cet utilitaire sous « **C:\temp** ».  

A propos du script « **_Collect_ETL.ps1_** » :  
Une fois les droits utilisateurs « **_AUTORITÉ NT / Système_** » obtenus, l’exécution du script permet d'automatiser la collecte des fichiers  
« **_.etl_** » sur l'ensemble du support visé de manière récursive.  
SHA-1 du script : « **_3133c0da57f69f09ed64ecc0251d5a871929842c_** ».  
Dans l’exemple présenté, on considère enregistrer ce script sous « **C:\temp** ».
<br />
<br />
## 2. Désactivation de la politique de sécurité d’exécution des scripts
Pour autoriser l'exécution des scripts PowerShell :  
•	Exécuter « **_Windows PowerShell_** » en tant qu’administrateur.

•	Vérifier la politique de sécurité appliquée à l’exécution des scripts en exécutant la commande :  
```{r, engine='bash', vérification politique de sécurité appliquée}
Get-ExecutionPolicy
```  
Si la réponse retournée est « **Restricted** », cela signifie que les scripts sont interdits à l’exécution. Il faut donc modifier cette restriction.

•	Autoriser l’exécution des scripts sans restriction en tapant la commande :
```{r, engine='bash', modification de la politique de sécurité appliquée}
Set-ExecutionPolicy Unrestricted
```  
•	Valider le changement de politique de sécurité en tapant la lettre « **T** ».
<br />
<br />
## 3. Obtention des droits « NT AUTHORITY\SYSTEM »
Pour la collecte des fichiers « **_.etl_** », l’utilisation du script PowerShell doit être exécuté avec les droits « **_AUTORITÉ NT / Système_** » (NT AUTORITY/SYSTEM).  
L’utilisation de ce compte permet de collecter l’ensemble des fichiers « **_.etl_** » sans restriction/blocage par rapport à leur emplacement dans l’arborescence du système.

Afin d’obtenir les privilèges de l’utilisateur « **_NT AUTHORITY\SYSTEM_** », il faut utiliser l’application « **_PsExec64.exe_** ».

•	Depuis une « **_Invite de commandes_** », exécutée en tant qu’administrateur, renseigner les commandes suivantes :  

```{r, engine='bash', se déplacer dans le dossier temp et exécuter PowerShell avec les droits Autorité NT / Système}
cd %SystemDrive%\temp
PsExec64.exe -u "NT AUTHORITY\System" -accepteula -i powershell 
```
<br />

## 4. Collecte des fichiers « .etl »
Depuis la fenêtre « **PowerShell** » nouvellemebnt ouverte, renseigner la commande suivante :  
```{r, engine='bash', exécuter le script Collect_ETL.ps1}
powershell C:\Temp\Collect_ETL.ps1  
```  
<br />

## 5. Réactivation de la politique de sécurité d’exécution des scripts

•	Interdire l’exécution des scripts en tapant la commande :  
```{r, engine='bash', interdire l'exécution des scripts PowerShell}
Set-ExecutionPolicy Restricted
```  

•	Valider le changement de politique de sécurité en tapant la lettre « **T** ».
