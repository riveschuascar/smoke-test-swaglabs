# Proyecto de Automatización Web

Framework de automatización de pruebas web desarrollado con **Ruby**, **Cucumber**, **Capybara** y **Selenium Manager**, siguiendo el enfoque **BDD (Behavior Driven Development)** mediante escenarios escritos en **Gherkin**.

## Tecnologías utilizadas

* Ruby
* Cucumber
* Capybara
* Selenium WebDriver
* Selenium Manager
* RSpec Expectations
* Rake

## Requisitos

### Versión de Ruby

El proyecto fue desarrollado y validado utilizando la siguiente versión de Ruby:

```text
rubyinstaller-devkit-3.0.2-1-x64.exe
```

Se recomienda utilizar exactamente esta versión para garantizar la compatibilidad de todas las dependencias.

Si se utiliza una versión diferente de Ruby, puede ser necesario eliminar el archivo:

```text
Gemfile.lock
```

y posteriormente reinstalar las dependencias mediante Bundler.

> Nota: aunque este procedimiento suele resolver conflictos de versiones, no se garantiza el correcto funcionamiento del proyecto con versiones distintas a la indicada anteriormente.

## Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/riveschuascar/smoke-test-swaglabs.git
cd smoke-test-swaglabs/
```

### 2. Instalar dependencias

El proyecto incluye un archivo `Gemfile` con todas las dependencias necesarias.

Ejecutar:

```bash
bundle install
```

## Estructura del proyecto

```text
├── features/
│   ├── 
│   ├── step_definitions/
│   │   └── *.rb
│   └── support/
│       ├── env.rb
│       ├── hooks.rb
├── reports/
│── *.feature
├── Gemfile
├── Gemfile.lock
├── Rakefile
└── README.md
```

### Descripción de carpetas

| Carpeta            | Descripción                                              |
| ------------------ | -------------------------------------------------------- |
| `step_definitions` | Implementación de los pasos definidos en los escenarios. |
| `support`          | Configuración global del framework y hooks.              |
| `reports`          | Reportes HTML generados después de la ejecución.         |

## Arquitectura BDD

El proyecto sigue la metodología BDD mediante:

### Features

Los casos de prueba son definidos en archivos `.feature` utilizando sintaxis Gherkin.

Ejemplo:

```gherkin
Feature: Inicio de sesión

  Scenario: Usuario inicia sesión correctamente
    Given el usuario se encuentra en la página de login
    When ingresa credenciales válidas
    Then visualiza la página principal
```

### Step Definitions

La implementación de los pasos se encuentra desacoplada de los escenarios en archivos Ruby dentro de:

```text
features/step_definitions
```

Esta separación permite mantener los escenarios legibles y orientados al negocio.

## Configuración de Capybara y Selenium

La configuración principal se encuentra en:

```text
features/support/env.rb
```

### Configuración aplicada

* Navegador Google Chrome.
* Ejecución mediante Selenium Manager.
* Ventana maximizada al iniciar.
* Sesión de invitado (`--guest`).
* Perfil temporal generado dinámicamente para cada ejecución.
* Tiempo máximo de espera de 15 segundos para elementos.
* No se utiliza servidor interno de Capybara.

Configuración actual:

```ruby
begin
  require 'rspec/expectations'
rescue LoadError
  require 'spec/expectations'
end

require 'tmpdir'
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'selenium-webdriver'

Capybara.run_server = false
Capybara.default_max_wait_time = 15

Capybara.register_driver :chrome_testing do |app|
  options = Selenium::WebDriver::Chrome::Options.new

  options.binary = 'C:/Program Files/Google/Chrome/Application/chrome.exe'
  options.add_argument('--start-maximized')
  options.add_argument('--disable-features=PasswordLeakDetection')
  options.add_argument("--user-data-dir=#{Dir.mktmpdir}")
  options.add_argument('--guest')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.default_driver = :chrome_testing
Capybara.javascript_driver = :chrome_testing
```

## Hooks

Actualmente el framework dispone del siguiente hook global:

```ruby
After do
  Capybara.reset_sessions!
end
```

### Funcionalidad

Después de cada escenario:

* Se eliminan las cookies de sesión.
* Se limpia el estado del navegador.
* Se evita contaminación entre escenarios.

## Ejecución de pruebas

Las ejecuciones se realizan mediante tareas definidas en el archivo `Rakefile`.

### Ejecutar todas las pruebas

```bash
rake all
```

### Ejecutar suite del Smoke Test

```bash
rake smoke
```

## Reportes

Al finalizar la ejecución de cualquiera de las tareas disponibles, el framework genera automáticamente un reporte en formato HTML.

Los reportes permiten visualizar:

* Escenarios ejecutados.
* Escenarios exitosos.
* Escenarios fallidos.
* Evidencia de errores (si aplica).
* Resultado consolidado de la ejecución.

## Buenas prácticas

* Mantener los escenarios enfocados en reglas de negocio.
* Evitar lógica compleja dentro de los archivos `.feature`.
* Reutilizar pasos siempre que sea posible.
* Mantener los `step_definitions` organizados por funcionalidad.
* Ejecutar periódicamente la suite `smoke` para validaciones rápidas.
* Utilizar la versión de Ruby recomendada para asegurar compatibilidad.

## Solución de problemas

### Error durante la instalación de gemas

Eliminar el archivo:

```text
Gemfile.lock
```

y volver a ejecutar:

```bash
bundle install
```

### Chrome no inicia

Verificar:

* Que Google Chrome esté instalado.
* Que la ruta configurada en `env.rb` sea válida:

```text
C:/Program Files/Google/Chrome/Application/chrome.exe
```

### Dependencias incompatibles

Confirmar que la versión utilizada sea:

```text
rubyinstaller-devkit-3.0.2-1-x64.exe
```

ya que es la versión sobre la cual fue construido y validado el framework.
