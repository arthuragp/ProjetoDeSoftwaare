// lib/screens/home_screen.dart
// [Arquivo pbr-si-2024-2-p5-tias-t1-9155101-grupo_EcoFin/src/ecofin/lib/screens/home_screen.dart]

import 'package:flutter/material.dart';
import 'package:ecofin/services/auth_service.dart';
import 'login_screen.dart';
import 'transactions_list_screen.dart';
import 'report_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'goals_list_screen.dart';
import 'accounts_list_screen.dart';
import 'alerts_screen.dart'; 
import 'investments_screen.dart';
import 'invoices_list_screen.dart'; // <-- NOVO IMPORT

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? user?.email ?? 'Usuário';

    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoFin Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Alertas',
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AlertsScreen()));
            },
          ),
          IconButton(
            tooltip: 'Sair',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'Bem-vindo(a),',
            style: TextStyle(fontSize: 20, color: Colors.grey[700]),
          ),
          Text(
            displayName,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          
          _MenuCard(
            title: 'Receitas',
            subtitle: 'Visualize e adicione suas receitas',
            icon: Icons.arrow_upward_rounded,
            iconColor: Colors.green,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TransactionsListScreen(type: 'income'))),
          ),
          const SizedBox(height: 16),

          _MenuCard(
            title: 'Despesas',
            subtitle: 'Visualize e adicione suas despesas',
            icon: Icons.arrow_downward_rounded,
            iconColor: Colors.red,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TransactionsListScreen(type: 'expense'))),
          ),
          const SizedBox(height: 16),

          _MenuCard(
            title: 'Minhas Contas',
            subtitle: 'Visualize o saldo de suas contas',
            icon: Icons.account_balance_wallet_rounded,
            iconColor: Colors.purple,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AccountsListScreen())),
          ),
          const SizedBox(height: 16),

          // --- NOVO CARD PARA FATURAS (RF10) ---
           _MenuCard(
            title: 'Faturas',
            subtitle: 'Gerencie suas contas a pagar',
            icon: Icons.receipt_long_rounded,
            iconColor: Colors.blueGrey,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const InvoicesListScreen())),
          ),
          const SizedBox(height: 16),
          // --- FIM DO NOVO CARD ---

          _MenuCard(
            title: 'Investimentos',
            subtitle: 'Acompanhe seus aportes',
            icon: Icons.trending_up_rounded,
            iconColor: Colors.cyan[700]!,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const InvestmentsScreen())),
          ),
          const SizedBox(height: 16),

          _MenuCard(
            title: 'Metas',
            subtitle: 'Acompanhe seus objetivos financeiros',
            icon: Icons.flag_rounded,
            iconColor: Colors.orange,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const GoalsListScreen())),
          ),
          const SizedBox(height: 16),

          _MenuCard(
            title: 'Relatórios',
            subtitle: 'Analise sua saúde financeira',
            icon: Icons.bar_chart_rounded,
            iconColor: Colors.blue,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ReportScreen())),
          ),
        ],
      ),
    );
  }
}

// Widget auxiliar _MenuCard (permanece igual)
class _MenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: iconColor.withOpacity(0.1),
                child: Icon(icon, color: iconColor, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}