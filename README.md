# marceladaguer.com

Este repositório contém o código fonte do site estático do domínio marceladaguer.com.

Índice
Visão Geral
Tecnologias Utilizadas
Arquitetura
Estrutura de Diretórios
Contato
Licença
Visão Geral
marceladaguer.com é um site estático desenvolvido para mostrar o portfólio e o blog de Marcela Daguer. Este site foi criado com HTML, CSS e JavaScript, e utiliza Terraform para gerenciar a infraestrutura.

Tecnologias Utilizadas
HTML5
CSS3
JavaScript
Terraform
Arquitetura
A arquitetura do site utiliza os seguintes serviços da AWS:

S3: Armazenamento dos arquivos estáticos do site.
Route 53: Gerenciamento do domínio marceladaguer.com.
ACM (AWS Certificate Manager): Criação e gerenciamento do certificado SSL.
CloudFront: CDN e entrega de conteúdo para melhorar a performance e a segurança.
Estrutura de Diretórios
A estrutura básica do projeto é a seguinte:
