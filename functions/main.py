# Copyright 2023 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# [START all]
# [START import]
# The Cloud Functions for Firebase SDK to create Cloud Functions and set up triggers.
from firebase_functions import firestore_fn, https_fn

# The Firebase Admin SDK to access Cloud Firestore.
from firebase_admin import initialize_app, firestore
import google.cloud.firestore

app = initialize_app()
# [END import]


# [START addMessage]
# [START addMessageTrigger]
@https_fn.on_call()
def addmessage(req: https_fn.Request) -> https_fn.Response:
    return 'fnawieofnweaoi'
    return https_fn.Response(f"Message with ID  added.")
    """Take the text parameter passed to this HTTP endpoint and insert it into
    a new document in the messages collection."""
    # [END addMessageTrigger]
    # Grab the text parameter.
    original = req.data
    if original is None:
        return https_fn.Response("No text parameter provided", status=400)

    # [START adminSdkPush]
    firestore_client: google.cloud.firestore.Client = firestore.client()

    # Push the new message into Cloud Firestore using the Firebase Admin SDK.
    _, doc_ref = firestore_client.collection("messages").add(
        {"original": original}
    )

    # Send back a message that we've successfully written the message
    return https_fn.Response(f"Message with ID {doc_ref.id} added.")
    # [END adminSdkPush]


# [END addMessage]