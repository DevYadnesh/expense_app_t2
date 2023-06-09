import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_proj/database/models/expense_model.dart';
import 'package:meta/meta.dart';

import '../../repo/expense_repo.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  Expense_Repo repo;

  ExpenseBloc({required this.repo}) : super(ExpenseInitialState()) {
    on<AddExpenseEvent>((event, emit)async {
      emit(ExpenseLoadingState());
    var check = await repo.addExpense(event.newExpense);
    if(check){
    var allExpenses =  await repo.getExpensesDayWise();
   await Future.delayed(Duration(seconds: 2),(){

   }).whenComplete(() =>  emit(ExpenseLoadedState(listExpense: allExpenses)));
    }else{
      emit(ExpenseErrorState(errorMsg: 'Error while adding Expense'));
    }

    });

    on<getExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      var allExpenses =  await repo.getExpensesMonthWise();
      emit(ExpenseLoadedState(listExpense: allExpenses));
    });
    on<getDayWiseExpensesEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      var allExpenses =  await repo.getExpensesDayWise();
      emit(ExpenseLoadedState(listExpense: allExpenses));
    });
    on<getMonthWiseExpensesEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      var allExpenses =  await repo.getExpensesMonthWise();
      emit(ExpenseLoadedState(listExpense: allExpenses));
    });
    on<getYearWiseExpensesEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      var allExpenses =  await repo.getExpensesYearWise();
      emit(ExpenseLoadedState(listExpense: allExpenses));
    });
  }
}
