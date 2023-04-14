load("render.star", "render")

def main():
    return render.Root(
        child = render.Box(
            width=64,
            height=32,
            color="#000",
        ),
    )