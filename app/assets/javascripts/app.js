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
        // url: '/texts',
        url: '/create',
        // this sends data with username
        data: { text: text, username: username, address: address }
      }).then(function successCallback(response) {
        vm.textList = response.data;
        vm.latest = vm.textList[0];
        console.log(vm.textList);
        console.log(vm.latest);
      }, function errorCallback(response) {
      });
    }

    vm.sendReply = function (reply_text, username, text_id, $event){
      $event.preventDefault();

      $http({
        method: 'POST',
        // this sends the data to texts path without username
        // url: '/texts',
        url: '/reply/create',
        // this sends data with username
        data: { reply_text: reply_text, username: username, text_id: text_id }
      }).then(function successCallback(response) {

      }, function errorCallback(response) {
      });
    }
  }
]);
