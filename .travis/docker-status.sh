#!/bin/bash
function main()
{
  docker ps -l | grep Exited
  if [ $? = 0 ];then
    #已经退出
    echo -e "\033[31mINFO\033[0m  Docker has STOP"
  else
    sleep 1s
    echo -e "\033[32mINFO\033[0m  Docker is RUNING..."
    main
  fi
}
main
