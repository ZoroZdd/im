<div class="modal fade" tabindex="-1" role="dialog" id="myModal" >
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            @if ($title)
            <div class="modal-header">
                <h4 class="modal-title">{{$title}}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            @endif
            <div class="modal-body">
                <p>{{$message}}</p>
            </div>
            <div class="modal-footer">
                @if ($type === 'alert')
                    <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
                @elseif ($type === 'confirm')
                    <button type="button" class="btn btn-primary">确认</button>
                @else
                    <button type="button" class="btn btn-primary">确认</button>
                @endif
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->