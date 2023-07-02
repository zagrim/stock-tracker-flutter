import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_tracker/models/alphavantage.dart';

const String apiUrl = 'https://www.alphavantage.co/query';

/*
GET https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=tesco&apikey=demo



GET https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=demo

❚ Required: symbol

The name of the equity of your choice. For example: symbol=IBM

❚ Required: interval

Time interval between two consecutive data points in the time series. The following values are supported: 1min, 5min, 15min, 30min, 60min

❚ Optional: adjusted

By default, adjusted=true and the output time series is adjusted by historical split and dividend events. Set adjusted=false to query raw (as-traded) intraday values.

❚ Optional: outputsize

By default, outputsize=compact. Strings compact and full are accepted with the following specifications: compact returns only the latest 100 data points in the intraday time series; full returns the full-length intraday time series. The "compact" option is recommended if you would like to reduce the data size of each API call.

❚ Optional: datatype

By default, datatype=json. Strings json and csv are accepted with the following specifications: json returns the intraday time series in JSON format; csv returns the time series as a CSV (comma separated value) file.

*/

Future<List<AlphaVantageSearchResult>> searchForSymbol(String searchPhrase) {
  return fetchJson(
    'function=SYMBOL_SEARCH&keywords=$searchPhrase',
    AlphaVantageSearchResult.unwrapResult,
  );
}

Future<List<AlphaVantageQuoteResult>> getQuote(String symbol) {
  return fetchJson(
    'function=GLOBAL_QUOTE&symbol=$symbol',
    AlphaVantageQuoteResult.unwrapResult,
  );
}

_withApiKey(String query) {
  return '$query&apikey=$apiKey';
}

_asJson(String query) {
  return '$query&datatype=json';
}

/*Future<List<AlphaVantageSearchResult>> fetchJson(String query) {
  return http
      .get(Uri.parse('$apiUrl?${_withApiKey(_asJson(query))}'))
      /*.then((response) {
        print(response.body);
        return response;
      })*/
      .then((response) => (jsonDecode(response.body)['bestMatches'] as List)
          .map((match) => AlphaVantageSearchResult.fromJson(match))
          .toList())
      .catchError(print);
}*/
Future<T> fetchJson<T>(String data, JsonMapper<T> jsonMapper) {
  return http
      .get(Uri.parse('$apiUrl?${_withApiKey(_asJson(data))}'))
      /*.then((response) {
        print(response.body);
        return response;
      })*/
      .then((response) => jsonMapper(jsonDecode(response.body)) as T)
      .catchError(print);
}

/*Future<http.Response> _onError() {

}*/

typedef JsonMapper<T> = Function(Map<String, dynamic>);
