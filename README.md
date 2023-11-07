# About
ROS2 commands: ros2cd, cbp, cb

## Install (only 1st time)
1. open a terminal and clone this repository to your PC
    ```
    cd ~ && git clone git@github.com:leinakanishi/ros2cd.git
    ```
2. set `$WS_ROOT` variable 
   1. open `ros2cd/usersetting.sh` with editor
    ```
    vi ~/ros2cd/usersetting.sh
    ```
    2. set your workspace path at line 2 in `ros2cd/usersetting.sh`, this is an example that your workspace directory is `~/ros2_ws`
    ```
    export WS_ROOT=$HOME/ros2_ws
    ```
3. add commands by sourcing
    ```
    echo "source ~/ros2cd/usersetting.sh" >> ~/.bashrc
    ```
4. close the terminal and reopen

## How to use   
### ros2cd
- `ros2cd` = `cd $WS_ROOT/src/pkg_dir/sub_dir`
- usage: `ros2cd [pkg_name]`
- move to packages directory in your workspace
- package name is completed by "Tab" keys
- [ ] `sub_dir` is not completed

### cbp
- `cbp` = `colcon build --symlink-install --packages-select`
- usage: `cbp [pkg_name]`
- build only selected packages in your workspace
- package name is completed by "Tab" keys

### cb
- `cb` = `colcon build --symlink-install`
- build all packages in your worksspace