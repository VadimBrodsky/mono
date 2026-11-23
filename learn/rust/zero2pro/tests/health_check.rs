// You can inspect what code gets generated
// using the `cargo expand --test health_check`
#[actix_web::test]
async fn health_check_works() {
    // arrange
    spawn_app().await;

    // we need to bring in `reqwest`
    // to perform HTTP requests against our application
    let client = reqwest::Client::new();

    // act
    let response = client
        .get("http://127.0.0.1:8000/health_check")
        .send()
        .await
        .expect("Failed to execute request.");

    // assert
    assert!(response.status().is_success());
    assert_eq!(Some(0), response.content_length());
}

// launch our application in the background
async fn spawn_app() {
    let server = zero2prod::run().expect("Failed to bind address");

    // launch the server as a background task
    let _ = actix_web::rt::spawn(server);
}
