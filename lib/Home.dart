import 'package:flutter/material.dart';
import 'package:tic_tac_toe/data_models.dart';


class HomePage extends StatefulWidget{



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

        String activePlayer ='x';
        bool garmOver = false;
        int turn = 0;
        String result = '';
        Game game = Game();
        bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SwitchListTile.adaptive(
                title: Text('Play Against The Computer',
                style: TextStyle(color: Colors.white,fontSize: 20),
                textAlign: TextAlign.center,
                ),





                value: isSwitched, onChanged: (bool newValue){

                  setState(() {
                  isSwitched = newValue;
                  });
                  }
              ),
              Divider(height: 9,thickness: 9,color: Colors.deepPurple,),
              SizedBox(height: 5,),

              Text("It's $activePlayer Player".toUpperCase(),
                 style: TextStyle(color: Colors.orange,fontSize: 32), ),

              Divider(height: 2,thickness: 1,color: Colors.deepPurple,),
              SizedBox(height: 2,),

              Expanded(child: GridView.count(
                padding: EdgeInsets.all(15),
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.0,
                children: List.generate(9, (index) => InkWell(
                  borderRadius: BorderRadius.circular(16),

                  onTap: garmOver? null: () => onTapFun(index) ,
                    child:Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).shadowColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child:
                        Center(
                          child:  Text( Player.playerX.contains(index)?'x':Player.playerO.contains(index)?'o': '',
                            style: TextStyle(color:Player.playerX.contains(index)?Colors.blue:Colors.pink ,fontSize:33),
                           ),
                        ),
                    ) ,


                  )

                  )
                ,


              )),



              Divider(height: 2,thickness: 1,color: Colors.deepPurple,),
              SizedBox(height: 2,),

              Text(result,
                style: TextStyle(color: Colors.orange,fontSize: 25),),

              SizedBox(height: 6,),
              Divider(height: 7,thickness: 12,color: Colors.deepPurple,),
              SizedBox(height: 10,),

              ElevatedButton.icon(onPressed: (){
                setState(() {
                  Player.playerX=[];
                  Player.playerO=[];
                  activePlayer ='x';
                  garmOver = false;
                  turn = 0;
                  result = '';
                });
              }, icon:Icon(Icons.replay), label: Text('Repeat the Game'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Theme.of(context).splashColor),
              ),),
            ],
          ),
        ),
      )
    );
  }

  onTapFun(int index)async {
    if((Player.playerX.isEmpty||!Player.playerX.contains(index))&&
        (Player.playerO.isEmpty||!Player.playerO.contains(index)) ) {
      game.playGame(index, activePlayer);
      updatState();

      if((isSwitched) && !(garmOver)){
        await game.autoPlay(activePlayer);

        updatState();

      }
    }
  }

  void updatState() {
    setState(() {
      activePlayer =(activePlayer =='x')?'o':'x';
      turn++;

      String winnerPlayer = game.checkWine();
      if( winnerPlayer!= ""){
        garmOver=true;
        result = '$winnerPlayer is the winner';

      }
      else if(!garmOver && turn ==9)
        result = "It's Draw";
    });

  }
}
