import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadleo_project/bloc/auth/auth_bloc.dart';
import 'package:quadleo_project/bloc/auth/auth_event.dart';
import 'package:quadleo_project/bloc/product/product_bloc.dart';
import 'package:quadleo_project/bloc/product/product_event.dart';
import 'package:quadleo_project/bloc/product/product_state.dart';
import 'package:quadleo_project/data/service/product_service.dart';
import 'package:quadleo_project/decoration/decoration.dart';

class Productlist extends StatelessWidget {
  const Productlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductBloc(ProductService())..add(FetchProducts()),
      child: const ProductView(),
    );
  }
}

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Center(child: textStyle("Products", 23, FontWeight.bold, Colors.black)),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
            icon:  Icon(Icons.logout),
          ),
        ],
        bottom: PreferredSize(
  preferredSize: const Size.fromHeight(55),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: TextField(
      onChanged: (value) {
        context.read<ProductBloc>().add(SearchProducts(value));
      },
      decoration: const InputDecoration(
        hintText: "Search",
        prefixIcon: Icon(Icons.search),
        border: UnderlineInputBorder(),
      ),
    ),
  ),
),

      ),
      
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return  Center(child: CircularProgressIndicator());
          }

          if (state is ProductLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: state.filtered.length,

              itemBuilder: (context, index) {
                final product = state.filtered[index];


                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                          child: Image.network(
                            product.image,
                            fit: BoxFit.contain,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            product.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "₹ ${product.price}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          if (state is ProductError) {
            return Center(child: Text(state.message));
          }

          return  SizedBox();
        },
      ),
    );
  }
}
