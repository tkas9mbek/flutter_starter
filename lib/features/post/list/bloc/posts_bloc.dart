import 'package:bloc/bloc.dart';
import 'package:flutter_starter/utils/bloc/load_state.dart';
import 'package:flutter_starter/utils/bloc/paginated_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'posts_bloc.freezed.dart';

@freezed
class PostsEvent with _$PostsEvent {
  const factory PostsEvent.requested() = _RequestedPostsEvent;

  const factory PostsEvent.moreRequested() =
      _MoreRequestedPostsEvent;
}

@freezed
class PostsState with _$PostsState {
  const factory PostsState.initial() = _InitialPostsState;

  const factory PostsState.success({
    required PaginatedData<WalkerWalking> data,
    required LoadState loadState,
  }) = _SuccessPostsState;

  const factory PostsState.loading() = _LoadingPostsState;

  const factory PostsState.failure(AppException exception) =
      _FailurePostsState;

  const PostsState._();

  List<WalkerWalking> get walkings => maybeMap(
        success: (state) => state.data.items,
        orElse: () => const [],
      );

  bool get loading => maybeMap(loading: (_) => true, orElse: () => false);
}

@injectable
class PostsBloc
    extends Bloc<PostsEvent, PostsState> {
  final WalkingRepository _walkingRepository;

  PostsBloc(this._walkingRepository)
      : super(const PostsState.initial()) {
    on<PostsEvent>(
      (event, emit) => event.when(
        requested: (showLoader) async {
          if (showLoader) {
            emit(const PostsState.loading());
          }

          try {
            final paginatedData = await _walkingRepository.getPosts(
              page: 1,
            );

            return emit(
              PostsState.success(
                data: paginatedData,
                loadState: LoadState.loaded,
              ),
            );
          } on AppException catch (e) {
            return emit(PostsState.failure(e));
          }
        },
        moreRequested: () => state.mapOrNull(
          success: (state) async {
            if (state.loadState.isLoading) {
              return;
            }

            emit(state.copyWith(loadState: LoadState.loading));

            final paginatedData = await _walkingRepository.getPosts(
              page: state.data.nextPage,
            );

            return emit(
              state.copyWith(
                data: state.data.merge(paginatedData),
                loadState: LoadState.loaded,
              ),
            );
          },
        ),
      ),
    );
  }
}
