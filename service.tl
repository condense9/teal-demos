import(hello, src.main, 1);


fn background () {
   print("starting background task...");
   sleep(5);
   print("done");
}


fn on_http(method, path, event) {
  if path == "/hello" {
    hello(event);
  }
  else if path == "/compute" {
    print("starting");
    async background();
    print("returning from main");
    {"session_id": sid()};
  }
  else {
    print(path);
    signal("error", "bad path");
  }
}

fn main() {
  on_http("POST", "/hello", {"body": {"name": "World"}})
}

// curl --data '{"name": "World"}' -H "Content-Type:application/json" $API
