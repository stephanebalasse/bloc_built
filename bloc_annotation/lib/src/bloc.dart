import 'dart:async';
import 'package:bloc_annotation/src/mixins/bloc_mixin.dart';
import 'package:rxdart/rxdart.dart';

import 'package:meta/meta.dart';

/// A [Bloc] is an abstraction of a view that exposes only [Stream] outputs
/// and [Sink] inputs.
///
/// Since a bloc manages several streams you must [dispose] it afterward for
/// closing all the underlying [subscriptions].
///
/// This class provides also a set of tools for helping with [Stream]s lifecycle :
///
/// * [subscriptions], [subjects] collections for automatically disposing
/// underlyning resources.
/// * [fromStream], [fromPublish], [fromSubject], [fromBehavior] are shortcuts for subscribing to
/// streams and add it to [subscriptions] collection.
class Bloc {
  /// Creates a new [Bloc] instance.
  Bloc() {
    (this as GeneratedBloc)?.subscribeParent(this);
  }

}
