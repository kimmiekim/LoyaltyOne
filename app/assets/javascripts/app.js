var myApp = angular.module('myApp', []);

myApp.controller('mainController', [
  '$http',
  function(
    $http
  ){
    var vm = this;

    vm.preventSubmit = function ($event){
      $event.preventDefault();
    }

    vm.sendText = function (text, username, address, $event){
      $event.preventDefault();

      $http({
        method: 'POST',
        // this sends the data to texts path without username
        url: '/create',
        // this sends data with username
        data: { text: text, username: username, address: address }
      }).then(function successCallback(response) {
        vm.textList = response.data;
        vm.latest = vm.textList[0];
      }, function errorCallback(response) {
      });
    }

    vm.sendReply = function (text, $index, $event){
      $event.preventDefault();

      // Save the index in the controller so that the index can be used
      vm.text_index = $index;

      $http({
        method: 'POST',
        // this sends the data to texts path without username
        url: '/reply/create',
        data: { 
          reply_text: text.reply_text,
          username: text.reply_username,
          text_id: text.id }
      }).then(function successCallback(response, $index, indexHolder) {
        var text_index = vm.text_index;
        var textObj = vm.textList[vm.text_index];
        // Refresh the list of replies on the specific text object
        vm.textList[text_index].replies = response.data;

        // Clear the form
        vm.textList[text_index].reply_text = undefined;
        vm.textList[text_index].reply_username = undefined;
        
      }, function errorCallback(response) {
      });
    }
  }
]);
