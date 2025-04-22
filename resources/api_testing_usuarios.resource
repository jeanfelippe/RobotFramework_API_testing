
*** Settings ***

Library     RequestsLibrary
Library     String
Library    Collections

*** Keywords ***
Criar um usuário novo

    ${palavra_aleatoria}        Generate Random String        length=4        chars=[LETTERS]
    ${palavra_aleatoria}        Convert To Lower Case           ${palavra_aleatoria}
    Set Test Variable    ${EMAIL_TEST}    ${palavra_aleatoria}@emailteste.com
    #Set Test Variable define variavel apenas para o caso de teste utilizado
    Log     ${EMAIL_TEST}

Cadastrar o usuário criado na ServeRest
    [Arguments]    ${status_code_desejado}
    #utilizando argumentos para poder utilizar a variavel status code desejado como expected status na linha 32
    ${body}    Create Dictionary   
    #informo os campos do body da API de cadastro,duvidas? verificar api cadastrar usuario https://serverest.dev/#/Usu%C3%A1rios/post_usuarios
    ...    nome=Fulano da Silva   
    ...    email=${EMAIL_TEST}    
    ...    password=1234    
    ...    administrador=true
    
   
    Log     ${body}

     Criar Sessao na ServeRest

     ${resposta}    POST On Session    alias=ServeRest    url=/usuarios    json=${body}    expected_status=${status_code_desejado}

     Log    ${resposta.json()}
     Set Test Variable    ${RESPOSTA}    ${resposta.json()}
     #guardou na variavel RESPOSTA a resposta json da api e colocou essa variavel como global podendo assim ser utilizada em outros testes


Criar Sessao na ServeRest

    Create Session    alias=ServeRest    url=https://serverest.dev

Conferir se o usuário foi cadastrado corretamente
    Log   ${RESPOSTA}
    #variavel global RESPOSTA retorna o response da variavel response.json
    Dictionary Should Contain Item    ${RESPOSTA}    message    Cadastro realizado com sucesso
    Dictionary Should Contain Key    ${RESPOSTA}    _id


Vou repetir o cadastro do usuário
    Cadastrar o usuário criado na ServeRest     status_code_desejado=400

Verificar se a API não permitiu o cadastro repetido
    Dictionary Should Contain Item    ${RESPOSTA}    message    Este email já está sendo usado

    
