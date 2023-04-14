from typing import Union

from fastapi import FastAPI
import os

app = FastAPI()

@app.get("/")
def read_root():
    return "Healthy"


@app.get("/render/{star}")
def render(star):
    # Check if file exists first
    if not os.path.exists(f'stars/{star}.star'):
        return {
            'result': False,
            'msg': f'{star}.star does not exist.'
        }
    os.system(f'pixlet render stars/{star}.star')
    return True


@app.get("/push/{star}")
def push(star):
    # Check if image exists first
    if not os.path.exists(f'stars/{star}.webp'):
        render(star)

    os.system(
        f'pixlet push {os.environ["DEVICE_ID"]}'
        f' stars/{star}.webp'
        f' --api-token {os.environ["API_TOKEN"]}'
    )
    return True