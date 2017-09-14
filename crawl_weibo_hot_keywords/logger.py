#coding=utf-8

import logging.config

__author__ = 'kelezyb'


class Logger(object):
    """
    日志类
    """
    def __init__(self):
        self.file = 'logger.conf'

    def get_logger(self, name="root"):
        """
        获得Logger对象
        """
        logging.config.fileConfig(self.file)
        return logging.getLogger(name)

logger = Logger().get_logger()
