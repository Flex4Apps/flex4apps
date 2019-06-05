Best practices
##############

Log file analysis
=================

The importance of logs
----------------------

In today's software industry, monolithic architectures are more and more replaced by smaller, distributed services. Paradigms such as cloud computing and microservices are central to this development.

While small programs providing one or a few well defined services are easy to understand in isolation, real-life systems often comprise a multitude of such programs, resulting in a high level of complexity and possibly unforeseen problems. The hardest part of fixing issues in such a system often consists of reconstructing the exact interactions and conditions under which the issue occured. Logging often is the only way by which this information can be made available. But log files do not only provide crucial information for problem-solving in distributed systems; they additionally are a data source from which valuable business insights can be obtained.

Modern large-scale web services often produce vast amounts of logs, which makes manual inspection and analysis unfeasible. Automated analysis techniques such as machine laerning can be applied to solve this problem. Cheap storage to save the logs and cheap computing power to analyse them are both available.

In this use case, tools to analyse unstructured log files are developed with the goal of creating an automated anomaly detection system. In this context, *anomaly* is defined as any irregular behaviour of the system on which the logs are produced, including software bugs and hardware failures. The real-life log files analysed within Flex4Apps are unstructured and produced by software running on complex telecommunication infrastructure elements.

How to format logs
------------------

The aim of the following guidelines on how to log is to facilitate analysis of the logging data, with a focus on automated analysis methods

**Write structured log messages.**
  Unstructured logs usually have a format similar to the following:

  ``[timestamp] [severity] [process_name] log_message``

  The log message itself consists of a simple, unstructured string, for example

  ``Failed login for user f4a (invalid password)``

  An equivalent structured message in JSON format is

  ``{“message type”: “failed login”, “parameters”: {“user”: “f4a”, “reason”: “invalid password”}}``

  For a human, an unstructured message is easy to interpret, but automatically extracting information from it is problematic. In the above unstructured example, a log parser would need to detect ``Failed login`` as the category or type of the message, ``f4a`` as the user and ``invalid password`` as the reason for the failed login. The information that ``invalid password`` is a reason for the failed login is not even explicitly present in the message. Treating a log message as a set of key-value pairs ensures that for every value present in the message, there exists a corresponding key or identifier, thus parsing information for subsequent analysis is made easy.

  An additional advantage of structured logs is that adding information to existing log statements in the source code will not break existing analysis scripts, since these scripts will rely on key-value pairs and not on the exact order of words in the message.

  A central component developed within the log analysis part of Flex4Apps is a log converter which is able to identify parameters in unstructured log messages and subsequently convert these messages to structured messages. Today, this feature is essential to perform analyses on a large variety of logs, since currently, unstructured log messages are still the norm.
  
**Use a single structured format throughout all parts of the application.**
  Otherwise, parsing logs from your application will only get more complicated.

**Provide event IDs.**
  Each source code statement producing a log entry should print a unique log ID. This makes filtering for specific messages or events easy.

**Ensure consistency of key names.**
  For entities which exist at different locations in the log-producing system, such as users, hosts, or session IDs, use the same key name in different message types. Do not use ``user`` for ``failed login`` and ``username`` for ``requesting password change``, but keep the key consistent by choosing ``user`` in both cases. Consistent keys allow for easy tracking of entities throughout the system by filtering for all log messages containing entries such as ``{“user”: “f4a”}``. A central dictionairy of existing key names which is accessible and modifiable by all developers may help to ensure consistency.

**Make it easy to distinguish between events happening at different points in the system, but at the same time.**
  This can be done by adding entries for hosts, processes, threads, etc. to log messages.

**Provide as much context as possible.**
  Treat each log message as a message about an event. All context necessary to understand the event should be present in the log message. Long log messages with many parameters are not an issue if they are well-structured, allowing for easy filtering of information relevant to the current analysis. Logging the class and function in which the event took place may be helpful.

  At the time of development, most likely you will not be able to think of all possible questions someone might want to answer with the help of the log files written by your application. Consequently, providing as much information as possible may prove helpful in the future.

**Severity levels have limited use in complex systems.**
  An upstream event may not be critical for the component in which it takes place, but may cause problems in a component further downstream. The downstream component may not be known to the developer of the upstream component, so choosing appropriate severity levels for all situations is not possible.

**Use fine-grained timestamps with time zones.**
  A granularity of atleast milliseconds ensures the correct order of events happening in fast succession can be reconstructed. Time zone information is essential in distributed systems where individual components may be located on different continents.
