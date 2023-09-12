import 'package:clean_architecture_flutter/app/modules/search/presenter/search/blocs/search_bloc.dart';
import 'package:clean_architecture_flutter/app/modules/search/presenter/search/states/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchPage extends StatefulWidget {
  final String title;
  const SearchPage({Key? key, this.title = 'Home'}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = Modular.get();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: 0,
          left: 8,
          right: 8,
          top: 8,
        ),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                bloc.add(value);
              },
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Search...'),
            ),
            Expanded(
              child: StreamBuilder(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  final state = bloc.state;
                  if (state is StartState) {
                    return const Center(
                      child: Text(
                        'Digite um texto.',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
                  if (state is FailureState) {
                    return const Center(
                      child: Text(
                        'Ocorreu um erro.',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    );
                  }

                  if (state is LoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final list = (state as SuccessState).list;
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, i) {
                      final item = list[i];
                      return ListTile(
                        title: Text(item.nickname),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            item.avatar,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
