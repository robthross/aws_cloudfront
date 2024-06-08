# Variaveis do Bucket

s3name          = "portal-robsonross"
tags            = "Ambiente de Dev"
cloudfront      = "robsonross"
s3_content      = ["financeiro", "associacao", "cadastro", "painel", "meus-dados", "vr-pague"]
origin          = "robsonross"
allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
cached_methods  = ["GET", "HEAD"]
path_pattern    = ["financeiro/*", "associacao/*", "cadastro/*", "painel/*", "meus-dados/*", "vr-pague/*"]

domain-aliases = {
    domain01 = "robsonrossa.com.br"
    domain02 = "thiagorossa.com.br"
    domain03 = "renatarossa.com.br"
}
