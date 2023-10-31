import 'package:digiday_admin_panel/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Transaction> transactions=[
      Transaction(
          transactionTitle: "Shopping",
          date: "Aug 25,2023",
          amount: "5000"),
      Transaction(
          transactionTitle: "Gaming",
          date: "July 25,2023",
          amount: "5000"),
      Transaction(
          transactionTitle: "Shop",
          date: "June 25,2023",
          amount: "5000"),
      Transaction(
          transactionTitle: "Shopping",
          date: "May 25,2023",
          amount: "5000"),
      Transaction(
          transactionTitle: "Bill",
          date: "April 25,2023",
          amount: "25000"),
    ];

    return SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
               BalanceCard(balance: "36,000",),
                SizedBox(height: getProportionateScreenHeight(20),),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  ButtonsCard(
                      icon: Icons.compare_arrows,
                      title: "Transaction",
                      color: Colors.redAccent.shade200),
                  ButtonsCard(
                      icon: Icons.arrow_downward_sharp,
                      title: "Withdraw",
                      color: Colors.green.shade600),
                ],),
                SizedBox(height: getProportionateScreenHeight(20),),
                Text("Recent Transactions",style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 22,
                  fontWeight: FontWeight.w700
                ),),
                SizedBox(height: getProportionateScreenHeight(20),),
                SizedBox(
                  height: getProportionateScreenHeight(300),
                  child: ListView.builder(
                      itemCount: transactions.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index){
                    return TransactionCard(
                        transactionTitle: transactions[index].transactionTitle,
                        date: transactions[index].date,
                        amount: transactions[index].amount);
                  }),
                )
              ],
            ),
          ),
        ));
  }
}

class Transaction {
  String transactionTitle;
String date;
String amount;

 Transaction({required this.transactionTitle,
   required this.date,
   required this.amount});
}

class BalanceCard extends StatelessWidget {
  String balance;

   BalanceCard({Key? key,
  required this.balance

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: getProportionateScreenHeight(200),
        width: getProportionateScreenWidth(350),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.orangeAccent.shade400,
        ),

        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30),
          vertical: getProportionateScreenHeight(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Your Balance",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700
              ),),
              Text("₹$balance",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w900
                ),)
            ],
          ),
        ),

      ),
    );
  }
}

class ButtonsCard extends StatelessWidget {
  IconData icon;
  String title;
  Color color;

  ButtonsCard({Key? key,
    required this.icon,
    required this.title,
    required this.color

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: getProportionateScreenHeight(100),
        width: getProportionateScreenWidth(150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),

        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20)),
          child: Column(
            children: [
              Icon(icon, color: Colors.white, size: 35,),
              Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                ),)
            ],
          ),
        ),

      ),
    );
  }
}


class TransactionCard extends StatelessWidget {
  String transactionTitle;
  String date;
  String amount;


  TransactionCard({Key? key,
    required this.transactionTitle,
    required this.date,
    required this.amount

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Center(
        child: Container(
          height: getProportionateScreenHeight(90),
          width: getProportionateScreenWidth(350),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue.shade50
          ),

          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20),
            horizontal: getProportionateScreenWidth(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(transactionTitle,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),),
                    Text(date,
                      style:  TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),),
                  ],
                ),
                Text("₹$amount",
                  style:  TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 25,
                    fontWeight: FontWeight.w900
                  ),),
              ],
            ),
          ),

        ),
      ),
    );
  }
}

