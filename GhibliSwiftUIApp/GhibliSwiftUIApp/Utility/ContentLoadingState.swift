import Foundation

enum ContentLoadingState<Value: Equatable>: Equatable  {
    case idle, loading, loaded(Value), error(String)
}
