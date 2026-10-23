- Setup
  collapsed:: true
	- ```shell
	  curl https://cbenv.cbhq.net/run-setup.sh -o run-setup.sh && zsh run-setup.sh && cbenv
	  
	  cbenv setup
	  
	  cbenv validate
	  
	  brew install grpc
	  
	  gem install cocoapods
	  
	  bundle exec pod install
	  
	  npx @cbhq/mono-env setup --group common mobile
	  
	  yarn
	  
	  yarn setup:app
	  ```
- Development
	- ```shell
	  # start the metro server
	  yarn start:app
	  yarn start:app:production
	  
	  # start the iOS simluator
	  yarn ios:app
	  ```