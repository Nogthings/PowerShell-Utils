# PowerShell Productivity Scripts for Developers

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A collection of PowerShell functions and aliases designed to streamline the daily workflow of developers. With these scripts, you can handle processes, search your code, and manage Git faster and more efficiently, directly from your terminal.

## ✨ Features

-   **Port Management:** Quickly check which process is using a port (`findport`) and terminate it if needed (`killport`).
-   **Code Searching:** Recursively find text within files in your project (`findtext`).
-   **Git Workflow:** Get a quick, compact status overview of your repository (`g`).
-   **Self-Discovery:** List all custom functions loaded from your profile so you don't forget your own tools (`MyFunctions`).

## 🚀 Installation

To make these functions available every time you open a terminal, you need to add them to your PowerShell profile.

1.  **Open your PowerShell profile file**. You can do this by running the following command in your terminal:

    ```powershell
    notepad $PROFILE
    ```

    > **Note:** If the command above gives an error or says the file doesn't exist, run this command first to create it:
    > `New-Item -Path $PROFILE -Type File -Force`
    > And then run `notepad $PROFILE` again.

2.  **Copy and paste** the entire content of your script file (`.ps1`) into the profile file that opened in Notepad.

3.  **Save and close** the file.

4.  **Reload your profile**. Either close and reopen your PowerShell terminal, or run the following command in your current session:

    ```powershell
    . $PROFILE
    ```

That's it! All functions and aliases will now be available for use.

## 🛠️ Available Functions

Here is a summary of the included functions and how to use them.

### `findport` (Find-Port)

Finds which process is using a specific TCP port. Ideal for diagnosing "port in use" errors.

**Usage:**

```powershell
findport 8080
```

**Example Output:**

```
LocalAddress LocalPort State  OwningProcess ProcessName
------------ --------- -----  ------------- -----------
::1          8080      Listen         12345 node
```

---

### `killport` (Stop-ProcessByPort)

Finds and stops the process that is occupying a specific port. It will ask for confirmation before terminating the process to prevent accidents.

**Usage:**

```powershell
killport 3000
```

**Example Output:**

```
Port 3000 is being used by: node (PID: 54321)

Confirm
Are you sure you want to perform this action?
Performing the operation "Stop-Process" on target "node (54321)".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):
```

---

### `findtext` (Find-TextInFiles)

Recursively searches for text within files. You can filter by file extension.

**Usage:**

```powershell
# Search for the string "api_key" in all files
findtext "api_key"

# Search for "User::class" only in .php files
findtext "User::class" -Extension *.php
```

---

### `g` (Get-GitStatusShort)

Displays a compact view of your Git repository's status, including the current branch. It's a shortcut for `git status -s -b`.

**Usage:**

```powershell
g
```

**Example Output:**

```
## main...origin/main
 M README.md
 A src/new-feature.js
?? config.local.json
```

---

### `MyFunctions`

Lists all custom functions loaded from your profile, showing what they do and how to use them.

**Usage:**

```powershell
MyFunctions
```

**Example Output:**

```
Available Functions in your environment: 'C:\Users\You\Documents\WindowsPowerShell\Microsoft.PowerOfficeShell_profile.ps1':

Function           Description                                                                   Use
--------           -----------                                                                   ---
Find-Port          Finds active TCP connections on a specified port and retrieves associated...  function Find-Port([int]$Port)
Stop-ProcessByPort Finds the process listening on a specified TCP port and stops it usi...       function Stop-ProcessByPort([int]$Port)
# ... and the other functions
```

## 📄 License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

# PowerShell Productivity Scripts for Developers

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Una colección de funciones y alias de PowerShell diseñados para agilizar el flujo de trabajo diario de los desarrolladores. Con estos scripts, puedes manejar procesos, buscar en tu código y gestionar Git de manera más rápida y eficiente directamente desde la terminal.

## ✨ Características

-   **Gestión de Puertos:** Revisa rápidamente qué proceso está usando un puerto (`findport`) y termínalo si es necesario (`killport`).
-   **Búsqueda de Código:** Encuentra texto de forma recursiva dentro de los archivos de tu proyecto (`findtext`).
-   **Flujo de Trabajo con Git:** Obtén un resumen rápido y compacto del estado de tu repositorio (`g`).
-   **Autodescubrimiento:** Lista todas las funciones personalizadas que has cargado en tu perfil para no olvidar tus herramientas (`MyFunctions`).

## 🚀 Instalación

Para que estas funciones estén disponibles cada vez que abres una terminal, debes agregarlas a tu perfil de PowerShell.

1.  **Abre tu archivo de perfil de PowerShell**. Puedes hacerlo ejecutando el siguiente comando en tu terminal:

    ```powershell
    notepad $PROFILE
    ```

    > **Nota:** Si el comando anterior da un error o dice que el archivo no existe, ejecútalo primero para crearlo:
    > `New-Item -Path $PROFILE -Type File -Force`
    > Y luego vuelve a ejecutar `notepad $PROFILE`.

2.  **Copia y pega** el contenido completo de tu archivo de scripts (`.ps1`) dentro del archivo de perfil que se abrió en el Bloc de notas.

3.  **Guarda y cierra** el archivo.

4.  **Recarga tu perfil**. Cierra y vuelve a abrir tu terminal de PowerShell, o ejecuta el siguiente comando en tu sesión actual:

    ```powershell
    . $PROFILE
    ```

¡Listo! Todas las funciones y alias estarán disponibles para su uso.

## 🛠️ Funciones Disponibles

Aquí hay un resumen de las funciones incluidas y cómo usarlas.

### `findport` (Find-Port)

Encuentra qué proceso está utilizando un puerto TCP específico. Es ideal para diagnosticar errores de "puerto en uso".

**Uso:**

```powershell
findport 8080
```

**Salida de Ejemplo:**

```
LocalAddress LocalPort State  OwningProcess ProcessName
------------ --------- -----  ------------- -----------
::1          8080      Listen         12345 node
```

---

### `killport` (Stop-ProcessByPort)

Encuentra y detiene el proceso que está ocupando un puerto. Te pedirá confirmación antes de terminar el proceso para evitar accidentes.

**Uso:**

```powershell
killport 3000
```

**Salida de Ejemplo:**

```
Puerto 3000 está siendo usado por: node (PID: 54321)

Confirmar
¿Está seguro de que desea realizar esta acción?
Realizando la operación "Detener proceso" en el destino "node (54321)".
[S] Sí  [A] Sí a todo  [N] No  [T] No a todo  [U] Suspender  [?] Ayuda (el valor predeterminado es "S"):
```

---

### `findtext` (Find-TextInFiles)

Busca de forma recursiva un texto dentro de los archivos. Puedes filtrar por extensión.

**Uso:**

```powershell
# Buscar la cadena "api_key" en todos los archivos
findtext "api_key"

# Buscar "User::class" solo en archivos .php
findtext "User::class" -Extension *.php
```

---

### `g` (Get-GitStatusShort)

Muestra una vista compacta del estado de tu repositorio Git, incluyendo la rama actual. Es un atajo para `git status -s -b`.

**Uso:**

```powershell
g
```

**Salida de Ejemplo:**

```
## main...origin/main
 M README.md
 A src/new-feature.js
?? config.local.json
```

---

### `MyFunctions`

Lista todas las funciones personalizadas que has cargado desde tu perfil, mostrando para qué sirven y cómo se usan.

**Uso:**

```powershell
MyFunctions
```

**Salida de Ejemplo:**

```
Available Functions in your environment: 'C:\Users\You\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1':

Function           Description                                                                   Use
--------           -----------                                                                   ---
Find-Port          Finds active TCP connections on a specified port and retrieves associated...  function Find-Port([int]$Port)
Stop-ProcessByPort Finds the process listening on a specified TCP port and stops it usi...       function Stop-ProcessByPort([int]$Port)
# ... y las demás funciones
```

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.
