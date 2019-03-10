/// An annotation used to specify that a field must be exposed as
/// an output [update].
class BlocUpdate {
  /// The name of the generated [update] property. If not precised, the
  /// name will be deduced from the annotated field name.
  final String name;
  final String type;

  /// Creates a new [BlocUpdate] instance.
  const BlocUpdate({this.name, this.type});
}

/// Default [BlocUpdate] annotation.
const update = BlocUpdate();
