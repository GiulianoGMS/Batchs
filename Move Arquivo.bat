@echo off
setlocal enabledelayedexpansion

set origem="\\10.110.160.15\consinco-arquivos\plusoft"
set destino="\\Ngo-fs-01\ecommerce-crm"

:: Para cada arquivo CSV na pasta de origem
for %%f in (%origem%\*.csv) do (
    :: Extrai o nome do arquivo (sem a extensão)
    set "nome_arquivo=%%~nf"

    :: Inicializa a variável tipo
    set "tipo="

    :: Exibe o nome do arquivo para depuração
    echo Processando arquivo: !nome_arquivo!

    :: Usa findstr para procurar palavras-chave no nome do arquivo
    echo !nome_arquivo! | findstr /i "Ext_Plusoft_Produto" >nul
    if !errorlevel! == 0 set "tipo=produtos"
  
    echo !nome_arquivo! | findstr /i "Ext_CRM_Produto_Full" >nul
    if !errorlevel! == 0 set "tipo=produtos"
    
    echo !nome_arquivo! | findstr /i "Ext_Plusoft_Pessoa" >nul
    if !errorlevel! == 0 set "tipo=pessoas"

    echo !nome_arquivo! | findstr /i "Ext_CRM_Pessoa_Full" >nul
    if !errorlevel! == 0 set "tipo=pessoas"
    
    echo !nome_arquivo! | findstr /i "Ext_CRM_Vendas" >nul
    if !errorlevel! == 0 set "tipo=vendas"
    
    echo !nome_arquivo! | findstr /i "Ext_Plusoft_Ofertas" >nul
    if !errorlevel! == 0 set "tipo=ofertas"
    
    echo !nome_arquivo! | findstr /i "Ext_Plusoft_Filial" >nul
    if !errorlevel! == 0 set "tipo=filial"

    echo !nome_arquivo! | findstr /i "Ext_CRM_ProdEmpresa" >nul
    if !errorlevel! == 0 set "tipo=produtos_por_loja"

    :: Verifica se o tipo foi encontrado
    if defined tipo (
        :: Exibe a pasta de destino para depuração
        echo Tipo identificado: !tipo!
        
        :: Cria a pasta de destino para o tipo, se não existir
        if not exist "%destino%\!tipo!" (
            mkdir "%destino%\!tipo!"
        )

        :: Move o arquivo para a pasta correspondente
        move "%%f" "%destino%\!tipo!\"

        echo Arquivo %%f movido para !tipo!.
    ) else (
        echo Tipo desconhecido para o arquivo: %%f
    )
)

echo Processamento completo.
pause
