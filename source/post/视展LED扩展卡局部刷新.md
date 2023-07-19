title: 视展LED扩展卡局部刷新
date: 2021-09-11 13:06:28 +0800
update: ""
author: linx
tags: []
categories: []
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: post
hide: false
toc: false
image: ""
subtitle: ""
config: {}


---



## 任务队列

代码来自`https://github.com/CuteLeon/TaskQueueDemo`

```c#
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace LEDManager
{
    /// <summary>
    /// 单元任务
    /// </summary>
    public abstract class UnitTask
    {
        /// <summary>
        /// 任务名称
        /// </summary>
        public string Name { get; set; } = string.Empty;

        /// <summary>
        /// 
        /// </summary>
        /// <param name="name"></param>
        public UnitTask(string name) => this.Name = name;
        public override string ToString() => $"任务：{this.Name}";

        /// <summary>
        /// 执行任务
        /// </summary>
        public abstract void Execute();
    }

    /// <summary>
    /// 任务队列
    /// </summary>
    public class TaskQueue<T> : IDisposable where T : UnitTask
    {
        #region 事件

        /// <summary>
        /// 有任务入队事件
        /// </summary>
        public event EventHandler<T> TaskEnqueued;// { add { } remove { } }

        /// <summary>
        /// 有任务出队事件
        /// </summary>
        public event EventHandler TaskDequeued;// { add { } remove { } }

        /// <summary>
        /// 队列开始执行
        /// </summary>
        public event DoWorkEventHandler QueueStarted;// { add { } remove { } }

        /// <summary>
        /// 队列停止执行
        /// </summary>
        public event RunWorkerCompletedEventHandler QueueStoped;// { add { } remove { } }

        /// <summary>
        /// 队列进入空闲状态
        /// </summary>
        public event EventHandler Idle;// { add { } remove { } }
        #endregion

        #region 属性

        /// <summary>
        /// 任务队列名称
        /// </summary>
        public string Name { get; set; } = string.Empty;
        public IntPtr handle { get; set; }

        /// <summary>
        /// 任务列表（线程安全）
        /// </summary>
        private ConcurrentQueue<T> Tasks { get; set; } = new ConcurrentQueue<T>();

        /// <summary>
        /// 任务列表（只读）
        /// </summary>
        public T[] ReadOnlyTasks { get => this.Tasks.ToArray(); }

        /// <summary>
        /// 队列内任务总数
        /// </summary>
        public int TaskCount { get => this.Tasks?.Count() ?? 0; }
        #endregion

        #region 变量

        /// <summary>
        /// 任务执行线程
        /// </summary>
        private readonly BackgroundWorker TaskWorker = new BackgroundWorker()
        {
            WorkerReportsProgress = false,
            WorkerSupportsCancellation = true
        };

        /// <summary>
        /// 任务控制信号量（防止队列循环空转）
        /// </summary>
        private readonly ManualResetEvent QueueEvent = new ManualResetEvent(false);
        #endregion

        public TaskQueue(string name)
        {
            this.handle = handle;
            this.Name = name;

            this.TaskWorker.DoWork += this.ExecuteTasks;
            this.TaskWorker.RunWorkerCompleted += this.ExecuteFinished;
        }

        /// <summary>
        /// 任务入队
        /// </summary>
        /// <param name="task"></param>
        public void Enqueue(T task)
        {
            if (task == null) return;

            if (this.TaskCount == 0 && this.TaskWorker.IsBusy)
            {
                Console.WriteLine($"<{this.Name}> 队列信号量 Enqueue-Set()");
                this.QueueEvent.Set();
            }
            this.Tasks.Enqueue(task);

            TaskEnqueued?.Invoke(this, task);
        }

        /// <summary>
        /// 任务出队
        /// </summary>
        /// <returns></returns>
        public T Dequeue()
        {
            bool result = this.Tasks.TryDequeue(out T task);
            if (result) TaskDequeued?.Invoke(this, null);
            return task;
        }

        /// <summary>
        /// 任务队列开始执行
        /// </summary>
        public void Start()
        {
            if (this.TaskWorker.IsBusy) return;
            this.TaskWorker.RunWorkerAsync();
        }

        /// <summary>
        /// 任务队列开始执行
        /// </summary>
        public void Start(object argument)
        {
            if (this.TaskWorker.IsBusy) return;
            this.TaskWorker.RunWorkerAsync(argument);
        }

        /// <summary>
        /// 任务队列停止执行
        /// </summary>
        public void Stop()
        {
            if (!this.TaskWorker.IsBusy) return;
            this.TaskWorker.CancelAsync();
            Console.WriteLine($"<{this.Name}> 队列信号量 Stop-Set()");
            this.QueueEvent.Set();
        }

        /// <summary>
        /// 开始轮询执行任务
        /// </summary>
        private void ExecuteTasks(object sender, DoWorkEventArgs e)
        {
            QueueStarted?.Invoke(this, e);
            Console.WriteLine($"<{this.Name}> 内 Worker 启动...");

            while (true)
            {
                try
                {
                    //Thread.Sleep(1000);
                    Console.WriteLine($"<{this.Name}> 队列内任务数：{this.TaskCount}");

                    if ((sender as BackgroundWorker).CancellationPending) return;
                    if (this.TaskCount == 0)
                    {
                        Console.WriteLine($"<{this.Name}> 队列信号量 Execute-WaitOne");
                        // 阻塞队列状态
                        this.QueueEvent.Reset();
                        this.QueueEvent.WaitOne();

                        //队列进入空闲状态，触发空闲事件
                        Idle?.Invoke(this, null);
                        //WaitOne 之后要先 continue 一次
                        continue;
                    }

                    T task = this.Dequeue();
                    if (task == null) continue;

                    task.Execute();
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"<{this.Name}> 队列内发生异常：{ex.Message}");
                }
            }
        }

        /// <summary>
        /// 任务轮询结束
        /// </summary>
        private void ExecuteFinished(object sender, RunWorkerCompletedEventArgs e)
        {
            Console.WriteLine($"<{this.Name}> 内 Worker 停止...");
            Console.WriteLine($"<{this.Name}> 队列内剩余任务数：{this.TaskCount}");

            if (e.Error != null) Console.WriteLine($"<{this.Name}> 队列内发生异常：{e.Error.Message}");
            QueueStoped?.Invoke(this, e);
        }

        #region IDisposable Support

        public void Dispose()
        {
            this.Stop();
            this.TaskWorker.Dispose();
            while (this.Tasks.TryDequeue(out T task)) { }
            this.Tasks = null;
            this.QueueEvent.Close();
            this.QueueEvent.Dispose();

            GC.SuppressFinalize(this);
        }
        #endregion
    }
}
```

## 自己写一个任务

```c#
using System;
using System.Collections.Generic;


namespace LEDManager
{
    public class LEDSendTask:UnitTask
    {
        private WindowInfo _wi;
        public LEDSendTask(string name, WindowInfo wi) : base(name) {
            _wi = wi;
        }
        public static CLEDSender LEDSender = new CLEDSender();
        public const int WM_LED_NOTIFY = 1025;
        private const int GREEN = 0xFF00;
        private const int YELLOW = 0x00FFFF;
        private const int RED = 0x0000FF;
        private static TSenderParam GetDevParam(string remoteIP,IntPtr handle, ushort imei=0)
        {
            TSenderParam param = new TSenderParam();
            param.devParam.devType = LEDSender.DEVICE_TYPE_UDP;
            param.devParam.comPort = 1;
            param.devParam.comSpeed = 0;
            param.devParam.locPort = 8881;
            param.devParam.rmtHost = remoteIP;
            param.devParam.rmtPort = 6666;
            param.devParam.dstAddr = imei;
            param.notifyMode = LEDSender.NOTIFY_BLOCK;
            param.wmHandle = (uint)handle;
            param.wmMessage = WM_LED_NOTIFY;
            return param;
        }
        private static int GetColor(int color)
        {
            switch (color)
            {
                case 1: return RED;
                case 2: return YELLOW;
                case 3: return GREEN;
                default:
                    return RED;
            }
        }
        private string Parse(Int32 sendResult)
        {
            if (sendResult == LEDSender.R_DEVICE_READY) return "正在执行命令或者发送数据...";
            else if (sendResult == LEDSender.R_DEVICE_INVALID) return "打开通讯设备失败(串口不存在、或者串口已被占用、或者网络端口被占用)";
            else if (sendResult == LEDSender.R_DEVICE_BUSY) return "设备忙，正在通讯中...";
            else return "无";
        }

        public override void Execute()
        {
            WinMessage.Send(_wi.handle, WinMessage.WM_LOG_MESSAGE, $"执行任务:{Name}");

            WinMessage.Send(_wi.handle, WinMessage.WM_LOG_MESSAGE, $"发送: {_wi.RemoteIP} 硬件地址: {_wi.IMEI}");

            foreach (var item in _wi.ObjList)
            {
                var K = (ushort)LEDSender.Do_MakeObject(CLEDSender.ROOT_PLAY_OBJECT, CLEDSender.ACTMODE_REPLACE, 0, 0, 0, item.ObjIndex, CLEDSender.COLOR_MODE_DOUBLE);
                var d = GetDevParam(_wi.RemoteIP,_wi.handle,0);
                if (item.IsScroll)
                {
                    LEDSender.Do_AddText(K,
                    item.Left, item.Top, item.Width, item.Height, //对象位置
                    CLEDSender.V_TRUE,//透明 
                    0, //边框
                    item.Text, //内容 
                    item.FontName, item.FontSize, GetColor(item.FontColor), item.Bold ? CLEDSender.WFS_BOLD : CLEDSender.WFS_NONE, //字体样式
                    0, //换行 
                    item.Alignment,//对齐
                    2, 5, // 进入动画 6 连续左滚 2 左滚
                    2, 5, // 退出动画
                    0, 5, 0 // 停留动画
                    );
                }
                else
                {
                    LEDSender.Do_AddText(K,
                                        item.Left, item.Top, item.Width, item.Height,//对象位置
                                        CLEDSender.V_TRUE, //透明 
                                        0,//边框
                                        item.Text, //内容 
                                        item.FontName, item.FontSize, GetColor(item.FontColor), item.Bold ? CLEDSender.WFS_BOLD : CLEDSender.WFS_NONE, //字体样式
                                        0,  //换行 
                                        item.Alignment//对齐
                                        );
                }

               var sendResult = LEDSender.Do_LED_SendToScreen(ref d, K);
                
                //WinMessage.Send(_wi.handle, WinMessage.WM_LOG_MESSAGE, $"发送led:{sendResult} {Parse(sendResult)}");
            }
            WinMessage.Send(_wi.handle, WinMessage.WM_LOG_MESSAGE, $"任务完成:{Name}");
        }
    }
    public class WindowInfo
    {
        public IntPtr handle { get; set; }
        public string RemoteIP { get; set; }
        public int IMEI { get; set; }
        public List<WindowObj2> ObjList { get; set; }
    }
    public class WindowObj2
    {
        public int Left { get; set; }
        public int Top { get; set; }
        public int Width { get; set; }
        public int Height { get; set; }
        public string Text { get; set; }
        public string FontName { get; set; }
        public int FontSize { get; set; }
        public bool Bold { get; set; }
        public int FontColor { get; set; }
        public bool IsScroll { get; set; }
        public int Alignment { get; set; }
        public int ObjIndex { get; set; }
        public int ObjType { get; set; }
    }
}

```

- 由于使用了任务队列，则无需异步发送，直接使用同步发送
  
```c#
param.notifyMode = LEDSender.NOTIFY_BLOCK;
param.wmHandle = (uint)handle;
param.wmMessage = WM_LED_NOTIFY;
```
wmHandle是必须的，可能dll在发送时需要句柄

- Do_LED_SendToScreen的第一个参数是ref，就是说每次发送会变化， 所以TSenderParam 每次发送都需要创建，否则在多次连续发送时会失败


- 这里直接使用 Do_MakeObject 这种更新对象的方式来更新led， 好处是每次发送的内容只是一小块区域。比如排队叫号里一个窗口一般由 窗口号 窗口名 交互区 三个对象组成，那么当我需要更新一个窗口的信息时，只要管三个对象即可。而如果使用节目的方式，则每次更新都要把整个led上的数据全部发送一遍，效率明显会比较低。对于每一块扩展卡而言，ObjIndex 必须唯一，这是标记每个对象用的
