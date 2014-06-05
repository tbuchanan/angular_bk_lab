BookApp = angular.module("BookApp", [])

BookApp.controller("BooksCtrl", ["$scope", "$http", ($scope, $http)->
  console.log "inside of the controller"
  $scope.books = []

  $http.get("/books.json").success (data)->
    $scope.books = data

  $scope.addBook = ->
    # for testing:
    # console.log "pushed the addBook button"
    # console.log $scope.newBook
    $http.post("/books.json", $scope.newBook).success (data)->
      console.log "Book is saved!"
      $scope.books.push(data)
      $scope.newBook = {}

  $scope.editBook = ->
    $http.put("/books/#{@book.id}.json", @book).success (data)=>
      console.log "Book is edited!"
      
  $scope.deleteBook = ->
    console.log @book
    index = @$index
    $http.delete("/books/#{@book.id}.json").success (data)=>
    $scope.books.splice(index, 1)
  ])    

  

# boilerplate code below
BookApp.config(["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
])