use zero2prod::main;

#[actix_web::test]
async fn health_check_works() {
    // arrange
    spawn_app().await.expect("Failed to spawn our app.");

    // we need to bring in `request`
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

async fn spawn_app() -> std::io::Result<()> {
    zero2prod::run().await
}
