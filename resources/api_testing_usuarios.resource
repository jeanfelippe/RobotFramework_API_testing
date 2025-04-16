
*** Settings ***

Library     RequestsLibrary
Library     String

*** Keywords ***
Criar um usuário novo

    ${palavra_aleatoria}        Generate Random String        length=4        chars=[LETTERS]
    ${palavra_aleatoria}        Convert To Lower Case           ${palavra_aleatoria}
    Set Test Variable    ${EMAIL_TEST}    ${palavra_aleatoria}@emailteste.com
    #Set Test Variable define variavel apenas para o caso de teste utilizado
    Log     ${EMAIL_TEST}


