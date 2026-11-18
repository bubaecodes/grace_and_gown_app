/// Lifecycle of a screen's data.
///
/// Every list screen starts at [loading], settles on [data], and moves to
/// [error] when a fetch fails — the error view's retry calls `reload()`,
/// which starts the cycle again. Swapping the sample data for a real API
/// only changes what `reload()` does; the screens keep switching on this.
enum LoadState { loading, data, error }
