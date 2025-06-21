# Carlos Flix - Informações Essenciais para Desenvolvimento

## Qualidade dos Filmes

- **Qualidade Alta:**  
  - Resolução: 1080p (Full HD)  
  - Áudio: AAC estéreo, 128 kbps  
  - Uso: Para TVs com boa conexão e qualidade máxima  

- **Qualidade Baixa:**  
  - Resolução: 480p  
  - Áudio: AAC estéreo, 96 kbps  
  - Uso: Para conexões lentas ou dispositivos com menor capacidade  

*Obs:* As duas qualidades são entregues via streaming HLS (`.m3u8` + segmentos `.ts`), com playlist mestre para alternância automática.

---

## Ferramentas Utilizadas

| Camada       | Tecnologia                           |
|--------------|------------------------------------|
| Backend      | Ruby on Rails                      |
| Frontend     | BrightScript (para app Roku)        |
| Servidor     | Ubuntu Server LTS                  |
| Proxy/Load Balancer | Nginx                          |

---

## Estrutura do Sistema

- **Servidor de Vídeo:**  
  - Armazena os vídeos segmentados em múltiplas qualidades no diretório `public/videos/`  
  - Servido via Nginx, com backend Rails para API e gerenciamento

- **Conversão de Vídeos:**  
  - Usar FFmpeg para gerar múltiplas versões (1080p e 480p)  
  - Preferência por conversão na máquina principal, com envio para servidor, para minimizar carga

- **Streaming:**  
  - Utiliza protocolo HLS para entregar vídeos em segmentos pequenos, garantindo melhor adaptação à largura de banda

- **Player Roku:**  
  - Desenvolvido em BrightScript, consome a playlist mestre `.m3u8` para alternar automaticamente entre qualidades conforme rede

---

## Armazenamento Estimado

| Espaço em Disco | Quantidade Aproximada de Filmes (2h cada, 1080p + 480p) |
|-----------------|---------------------------------------------------------|
| 1 TB            | ~450 a 590 filmes                                       |
| 500 GB          | ~225 a 295 filmes                                       |

---

## Recomendações Gerais

- Utilize SSD para melhor desempenho no servidor, especialmente para leitura rápida dos segmentos  
- Separe diretórios temporários para upload e conversão, evitando impactar streaming em andamento  
- Configure FFmpeg para balancear qualidade e tamanho, com CRF adequado (ex: 26 para 1080p)  
- Crie playlists mestre para oferecer múltiplas qualidades e garantir melhor experiência ao usuário