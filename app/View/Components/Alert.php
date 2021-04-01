<?php

namespace App\View\Components;

use Illuminate\View\Component;

class Alert extends Component
{
    public $message;
    public $title;
    public $type;
    /**
     * Create a new component instance.
     *
     * @return void
     */
    public function __construct(string $message,$title = '',$type = 'alert')
    {
        // 标题
        $this->title = $title;
        // 提示信息
        $this->message = $message;
        // 类型
        $this->type = $type;
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\View\View|string
     */
    public function render()
    {
        return view('components.alert');
    }
}
