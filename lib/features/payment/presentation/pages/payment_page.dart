import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/payment_bloc.dart';
import '../bloc/payment_event.dart';
import '../bloc/payment_state.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _selectedPlan;
  int _amount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subscribe & Go Premium')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Choose a plan:'),
            ListTile(
              title: const Text('Monthly'),
              subtitle: const Text('2,000 XAF / month'),
              leading: Radio<String>(
                value: 'monthly',
                groupValue: _selectedPlan,
                onChanged: (v) => setState(() {
                  _selectedPlan = v;
                  _amount = 2000;
                }),
              ),
            ),
            ListTile(
              title: const Text('Semester'),
              subtitle: const Text('10,000 XAF / semester'),
              leading: Radio<String>(
                value: 'semester',
                groupValue: _selectedPlan,
                onChanged: (v) => setState(() {
                  _selectedPlan = v;
                  _amount = 10000;
                }),
              ),
            ),
            const SizedBox(height: 24),
            BlocConsumer<PaymentBloc, PaymentState>(
              listener: (context, state) {
                if (state is PaymentSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment successful!')),
                  );
                } else if (state is PaymentFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is PaymentLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  onPressed: _selectedPlan == null
                      ? null
                      : () {
                          context.read<PaymentBloc>().add(
                            MakePaymentEvent(
                              amount: _amount,
                              planId: _selectedPlan!,
                            ),
                          );
                        },
                  child: const Text('Pay & Go Premium'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
