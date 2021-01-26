class QueryMutation {
  // String addPerson(String id, String name, String lastName, int age) {
  //   return """
  //     mutation{
  //         addPerson(id: "$id", name: "$name", lastName: "$lastName", age: $age){
  //           id
  //           name
  //           lastName
  //           age
  //         }
  //     }
  //   """;
  // }

  String getLeagueData() {
    return """
    query{
      standings{
        color
        username
        win
        played
        elo
      }
      games (latest:10) {
        player1{username,color}
        player2{username,color}
        score12
        player3{username,color}
        player4{username,color}
        score34
        id
        deltaPoints
      }
      players{
        username
        goldMedals
        silverMedals
        bronzeMedals
      }
    }
    """;
  }

  String getPlayersList() {
    return """
    query{
      players{
        username
      }
    }
    """;
  }

  String getPlayerData(String player) {
    return """
    query{
      players (username: "$player") {
        username
        careerWin
        careerPlayed
        teammates {
          username
          gamesTogether
          winTogether
          gamesAgainst
          winAgainst
        }
      }
      games (latest:10, player: "$player") {
        player1{username,color}
        player2{username,color}
        score12
        player3{username,color}
        player4{username,color}
        score34
        id
        deltaPoints
      }
    }
    """;
  }

  String addGame(String p1, String p2, String p3, String p4, int score12, int score34) {
    return """
    mutation {
      createGame (
        input: {
          player1: "$p1"
          player2: "$p2"
          player3: "$p3"
          player4: "$p4"
          score12: $score12
          score34: $score34
        }
      ) {id}
    }
    """;
  }

  String login(String username, String password){
    return """
    mutation {
      login(input: { username: "$username", password: "$password" })
    }
    """;
  }

  String signUp(String username, String password){
    return """
    mutation{
      createUser(input:{username: "$username", password: "$password"})
    }
    """;
  }
}