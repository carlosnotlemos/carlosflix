# 🎬 Tutorial: Codificando Vídeos em HLS com FFmpeg

Este tutorial mostra como analisar, preparar e codificar um vídeo para streaming via HLS (HTTP Live Streaming) com qualidade de áudio e vídeo ideais.

---

## 📁 Pré-requisitos

- `ffmpeg` e `ffprobe` instalados
- Estrutura de diretório no projeto:
  ```
  public/videos/NOME_DO_FILME/1080p/
  ```

---

## 📌 1. Verificar informações do vídeo e áudio

### 🎥 Informações do Vídeo

```bash
ffprobe -v error -select_streams v:0 \
  -show_entries stream=codec_name,profile,bit_rate,width,height \
  -of default=noprint_wrappers=1 \
  "SEU_VIDEO.mkv"
```

### 🔊 Informações do Áudio

```bash
ffprobe -v error -select_streams a:0 \
  -show_entries stream=codec_name,channels,bit_rate \
  -of default=noprint_wrappers=1 \
  "SEU_VIDEO.mkv"
```

### 📊 Bitrate total (média)

```bash
ffprobe -v error -select_streams v:0 \
  -show_entries format=bit_rate \
  -of default=noprint_wrappers=1:nokey=1 \
  "SEU_VIDEO.mkv"
```

---

## 📂 2. Criar a pasta de saída

```bash
mkdir -p public/videos/NOME_DO_FILME/1080p
cd public/videos/NOME_DO_FILME
```

---

## ⚙️ 3. Codificar vídeo para HLS com áudio normalizado

```bash
ffmpeg -i /caminho/para/SEU_VIDEO.mkv \
  -c:v libx264 -crf 18 -preset veryfast \
  -profile:v main -level 4.0 \
  -c:a aac -b:a 192k -af loudnorm \
  -hls_time 10 \
  -hls_playlist_type vod \
  -hls_segment_filename "1080p/index_%03d.ts" \
  1080p/index.m3u8
```

> 🎧 O filtro `-af loudnorm` normaliza o volume do áudio para evitar picos altos ou partes muito baixas.

---

## 📄 4. Criar o arquivo `master.m3u8`

Crie um arquivo chamado `master.m3u8` dentro da pasta do filme com o seguinte conteúdo:

```m3u8
#EXTM3U
#EXT-X-VERSION:3

# 1080p
#EXT-X-STREAM-INF:BANDWIDTH=2300000,RESOLUTION=1920x800,CODECS="avc1.64001f,mp4a.40.2"
1080p/index.m3u8
```

> 💡 Use o valor de `BANDWIDTH` com base no bitrate total aproximado do vídeo + áudio (em bps).

---

## ✅ 5. Estrutura final esperada

```
public/videos/matrix_1999/
├── master.m3u8
├── thumbnail.jpeg
└── 1080p/
    ├── index.m3u8
    ├── index_000.ts
    ├── index_001.ts
    └── ...
```

Agora seu vídeo está pronto para ser servido por streaming HLS!
