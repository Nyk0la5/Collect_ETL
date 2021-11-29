# Collect_ETL
Ce projet a pour but de partager un script PowerShell de collecte des fichiers ETL sous environnement Windows.

1] La collecte en live des fichiers « .etl » nécessite en premier lieu la récupération de deux outils :
•	l’outil « PsExec64.exe » de la suite « SystinternalsSuite » ;
•	le script « Collect_ETL.ps1 ».

A propos de « PsExec64.exe » :
Cet outil libre de droit, est téléchargeable depuis le site Microsoft via le lien suivant : « https://download.sysinternals.com/files/SysinternalsSuite.zip ».
SHA-1 de « PsExec64.exe » : « 6c79d9ca8bf0a3b5f04d317165f48d4eedd04d40 ».
Ce soft nous permettra notamment d'obtenir les droits de l'utilisateur « AUTORITÉ NT / Système » nécessaires à la suite des opérations.
Dans l’exemple présenté, on considère enregistrer cet utilitaire sous « C:\temp ».

A propos du script « Collect_ETL.ps1 » :
Une fois les droits utilisateurs « AUTORITÉ NT / Système » obtenus, l’exécution du script permet d'automatiser la collecte des fichiers « .etl » sur l'ensemble du support visé de manière récursive.
Ce script est disponible depuis le lien suivant : « ».
SHA-1 du script : « 3133c0da57f69f09ed64ecc0251d5a871929842c ».
Dans l’exemple présenté, on considère enregistrer ce script sous « C:\temp ».

                                                            ___________________
                                                            

2] Désactivation de la politique de sécurité d’exécution des scripts
Par défaut, dans un souci de sécurité et afin de ne pas rendre possible l’exécution de scripts sans autorisation de l’administrateur, la configuration de Windows ne permet pas l'exécution de scripts PowerShell.
Pour autoriser l'exécution des scripts PowerShell, il suffit de modifier la politique de sécurité appliquée en termes d'exécution des scripts.
•	Exécuter « Windows PowerShell » en tant qu’administrateur.

•	Vérifier la politique de sécurité appliquée à l’exécution des scripts en exécutant la commande :
PS C:\WINDOWS\system32> Get-ExecutionPolicy

Si la réponse retournée est « Restricted », cela signifie que les scripts sont interdits à l’exécution. Il faudra donc modifier cette restriction.

•	Autoriser l’exécution des scripts sans restriction en tapant la commande :
PS C:\WINDOWS\system32> Set-ExecutionPolicy Unrestricted

•	Valider le changement de politique de sécurité en tapant la lettre « T ».

                                                            ___________________
                                                            

3] Obtention des droits « NT AUTHORITY\SYSTEM »
Pour la collecte des fichiers « .etl », l’utilisation du script PowerShell doit être exécuté avec les droits « AUTORITÉ NT » (NT AUTORITY). Les utilisateurs « AUTORITÉ NT » sont des utilisateurs systèmes intégrés à Windows avec des privilèges plus élevés que celui du compte administrateur. Il existe plusieurs comptes « AUTORITÉ NT ». Ils sont utilisés par Windows pour lancer des processus systèmes ou services Windows. Celui qui nous intéresse est « Système » (System) car ce compte a les privilèges les plus élevés sur Windows. L’utilisation de ce compte permet de collecter l’ensemble des fichiers « .etl » sans restriction/blocage par rapport à leur emplacement dans l’arborescence du système.

Afin d’obtenir les privilèges de l’utilisateur « NT AUTHORITY\SYSTEM », il faut utiliser l’application « PsExec64.exe ».

•	Depuis une « Invite de commandes », exécutée en tant qu’administrateur, renseigner les commandes suivantes :
C:\WINDOWS\system32>cd %SystemDrive%\temp
C:\temp>PsExec64.exe -u "NT AUTHORITY\System" -accepteula -i powershell

                                                            ___________________
                                                            

4] Collecte des fichiers « .etl »
Depuis la fenêtre PowerShell ouverte, renseigner la commande suivante :
PS C:\WINDOWS\system32> powershell C:\Temp\Collect_ETL.ps1

                                                            ___________________
                                                            

5] Réactivation de la politique de sécurité d’exécution des scripts
À la suite de la modification de la politique de sécurité concernant l’exécution des scripts sans restriction afin de faciliter la collecte de fichiers « .etl », il nous faut maintenant réactiver la politique par défaut.

•	Interdire l’exécution des scripts en tapant la commande :
PS C:\WINDOWS\system32> Set-ExecutionPolicy Restricted

•	Valider le changement de politique de sécurité en tapant la lettre « T ».


