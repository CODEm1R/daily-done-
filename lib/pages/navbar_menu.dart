import 'package:flutter/material.dart';
import 'package:todo_app/pages/drawers_pages/completed_tasks.dart';
import 'package:todo_app/pages/drawers_pages/favorite_tasks.dart';
import 'package:todo_app/pages/drawers_pages/profile.dart';

class NavBarMenu extends StatelessWidget {
  const NavBarMenu ({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, // bg photo full screen
        children: [
          const UserAccountsDrawerHeader(
              accountName: Text("Emir Sağlam",style: TextStyle(color: Colors.black)),
              accountEmail: Text(
                  "emirsaglam.4747@gmail.com",
                  style: TextStyle(color: Colors.black)),
              /*currentAccountPicture: GestureDetector(
                onDoubleTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) => ProfilePage()
                  )
                  ); // Navigator
                }, child: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      'https://scontent.fesb3-1.fna.fbcdn.net/v/t39.30808-6/316263180_1394766900933000_7313269488005133150_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=1zBcTyatuCMQ7kNvgGf1zJO&_nc_ht=scontent.fesb3-1.fna&oh=00_AYD80CzDO_FsSob8Ru2tfz-y2XK2HBewAKvpDBnXCZ7IHg&oe=66C37341',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),*/
            /*decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage('https://mysoftcrm.com/wp-content/uploads/2020/12/G%C3%B6rev.png'),
                  fit: BoxFit.cover
              ),
            ), */
          ),
          ListTile(
            leading: const Icon(Icons.person_rounded),
            title: const Text("My Account"),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfilePage()));},
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Favorite Task"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FavTask()));},
          ),
          ListTile(
            leading: const Icon(Icons.task_rounded),
            title: const Text("Completed Task"),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>CompletedTask()));},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfilePage()));},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Exit"),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfilePage()));},
          ),

        ],
      ),
    );
  }
}
