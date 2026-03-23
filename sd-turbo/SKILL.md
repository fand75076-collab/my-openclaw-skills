# SD-Turbo Image Generator

Generate images locally with SD-Turbo and send to Telegram.

## Usage

When user asks to generate an image:
1. Run the Python script with the prompt
2. Send the generated image to Telegram via `message` tool

## Command

```powershell
python C:\Users\Administrator\.openclaw\workspace\sd-turbo-gen.py "prompt" -o "C:\Users\Administrator\.openclaw\workspace\sd-turbo-output.png"
```

## Steps

1. Parse user's image request -> construct prompt
2. Run: `python sd-turbo-gen.py "<prompt>"`
3. Read output path from stdout
4. Call `message` tool with `action=send`, `media=<path>`, `target=telegram`
5. Clean up temp file (optional)

## Parameters

| Param | Default | Notes |
|-------|---------|-------|
| steps | 1 | More steps = better quality but slower |
| output | workspace/sd-turbo-output.png | Temp file location |

## Example Workflow

```
User: "生成一张机器人弹钢琴的图"
1. exec: python sd-turbo-gen.py "A cinematic shot of a robot playing piano, dramatic lighting, 4k"
2. message: action=send, media=output_path, target=telegram
```

## Notes

- Model location: D:\models\sd-turbo
- GPU: RTX 4070
- Generation time: ~1s per image
- Model stays in memory for faster subsequent generations
