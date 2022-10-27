abstract class ICounterEvent{}

class IncrementEvent implements ICounterEvent{}
class DecrementEvent implements ICounterEvent{}

class ShowDialogEvent implements ICounterEvent{}
class StartAnimationEvent implements ICounterEvent{}
class NavigateToPageEvent implements ICounterEvent{}
class ShowBottomSheetEvent implements ICounterEvent{}
