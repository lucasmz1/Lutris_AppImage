import sys,os
import _strptime
import lutris
import gettext
import json
import logging
import signal
import tempfile
import datetime
import typing
import gi
import socket
import optparse
import pickle
import queue
import copy
import configparser
import urllib
import base64
import email
import hashlib
import http
import quopri
import calendar
import uu
import requests
import subprocess
import pathlib
import glob
import platform
import resource
import ctypes
import shlex
import uuid
import sqlite3
import inspect
import dbus
import yaml
import concurrent
import gzip
import tarfile
import secrets
import dataclasses
import PIL
import numbers
import lxml
import multiprocessing
import filecmp
import collections
import encodings
import importlib
import concurrent
prefix = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(sys.path[0]))))
sys.path = [ prefix+s for s in sys.path if not s.startswith(prefix) ]
