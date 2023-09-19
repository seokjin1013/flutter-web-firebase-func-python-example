from firebase_functions import https_fn
from firebase_admin import initialize_app
from typing import Any

app = initialize_app()

@https_fn.on_call()
def on_call_function(req: https_fn.CallableRequest) -> Any:
    return f"on_call_function_success_response {req.data['text']}"