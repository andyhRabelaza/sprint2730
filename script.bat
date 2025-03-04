@echo off
setlocal

:: Répertoires
set "TEMP_SRC=temp_src"
set "MY_CLASSES=classes"

:: Création du répertoire temporaire
:: Vérifier si le répertoire de destination existe
if exist "%TEMP_SRC%" (
    echo Le répertoire de destination existe déjà. Suppression en cours...
    rmdir /s /q "%TEMP_SRC%"
    echo Répertoire de destination supprimé avec succès.
)
mkdir "%TEMP_SRC%"
echo Répertoire temporaire pour source créé

:: Vérifier si le répertoire de destination existe
if exist "%MY_CLASSES%" (
    echo Le répertoire de destination existe déjà. Suppression en cours...
    rmdir /s /q "%MY_CLASSES%"
    echo Répertoire de destination supprimé avec succès.
)
mkdir "%MY_CLASSES%"
echo Répertoire temporaire pour les .class créé

:: Copier les fichiers Java du répertoire source vers temp_src
for /R "src" %%f in (*.java) do (
    copy "%%f" "%TEMP_SRC%"
)

:: Changer de répertoire vers TEMP_SRC
pushd "%TEMP_SRC%"
:: Compilation des fichiers Java dans le répertoire TEMP_SRC vers classes
javac -cp "..\lib\*" -d "..\%MY_CLASSES%" *.java
echo Fichiers Java compilés dans le répertoire classes
popd

:: Création du fichier jar
jar cf "lib\front-controller.jar" -C "%MY_CLASSES%" .
echo Fichier jar créé avec succès.

endlocal
