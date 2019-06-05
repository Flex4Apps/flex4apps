Best practices
##############

Cloud solutions and software as a service
=========================================

Business best practices
-----------------------

-	Discuss and identify a feedback loop. Product managers and stakeholders can use the data to focus on important topics but will have to consciously look at the data and interpret it to form good decisions.

-	Make sure to invest time in generating reports, spreadsheets or other forms of data that is usable by business users who actually want the data. If the form is not accessible enough it will not be used.

-	Design for flexibility. As soon as data is available, new questions will arise which potentially need extra data to be gathered.
-	Think about security and Data Protection. GDPR can have a significant impact if you collect data that might be identifiable.

-	Think about the lifetime of the analytics. Storing everything forever might be a good idea but more often than not the value decreases rapidly. Make sure to pass this to the technical process.

Technical best practices
------------------------

- **In cloud solutions, stateful deployments need the most attention.**
  
  Before starting Flex4Apps, project partners believed that managing fail-over scenarios for high-availability installations is the part which is most difficult to handle.

  During learning about cluster deployment, we realized various solutions exist for stateless services. Tasks become complicated if services need persistence (so-called stateful services).

  Storage has to be provided as an extra high-availability service, which makes it cost intensive. An alternative approach is to look for storage software which inherits support for multi-node cluster deployment. This can mean that a vendor lock-in can't be avoided. 

- **S3 can be a good light cloud storage.**

  There is no vendor lock-in, because various implementations at commercial clouds exist next to various open source implementations. S3 can be deployed on small single nodes or on clusters with redundancy for high availability. However, S3 is only suited for pure storage, not for complex querying.

  If S3 is not good enough, there is no one-size-fits-all solution out there right now. Most secure and usable solutions are bound to a cloud provider. Check costs and functions of storage and for other needed functions of the cloud provider.
-	Be aware of the cost factors of the chosen solution and see where the dominant factors lie as volumes increase.

-	Compress close at the source (and try and match optimal parameters) because transmission costs can otherwise be very high.

-	Filter data (preferably dynamically) at the source to keep storage and analytics persistency costs down.

-	Unpredictable traffic surges might overwhelm your end-points. Also make sure to keep in mind where your clients are sending the data. Don't reinvent the wheel. Sending directly to AWS Kinesis Firehose will handle any load but requires AWS credentials.

-	Define if and what *real-time* means for your use case. If the real time can work asynchronously and tolerate delays you can design the system to be very cost efficient.

-	Don't try and find the ideal storage solution as there is none that is fully cross platform and portable across all cloud vendors unless you sacrifice features (dropping down to standard SQL instead of NoSQL, Big Data or analytic systems). Mix and match storage solutions as you see fit.

Log file analysis
=================

The importance of logs
----------------------

In today's software industry, monolithic architectures are more and more replaced by smaller, distributed services. Paradigms such as cloud computing and microservices are central to this development.

While small programs providing one or a few well defined services are easy to understand in isolation, real-life systems often comprise a multitude of such programs, resulting in a high level of complexity and possibly unforeseen problems. The hardest part of fixing issues in such a system often consists of reconstructing the exact interactions and conditions under which the issue occurred. Logging often is the only way by which this information can be made available. But log files do not only provide crucial information for problem-solving in distributed systems; they additionally are a data source from which valuable business insights can be obtained.

Modern large-scale web services often produce vast amounts of logs, which makes manual inspection and analysis unfeasible. Automated analysis techniques such as machine learning can be applied to solve this problem. Cheap storage to save the logs and cheap computing power to analyse them are both available.

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
  For entities which exist at different locations in the log-producing system, such as users, hosts, or session IDs, use the same key name in different message types. Do not use ``user`` for ``failed login`` and ``username`` for ``requesting password change``, but keep the key consistent by choosing ``user`` in both cases. Consistent keys allow for easy tracking of entities throughout the system by filtering for all log messages containing entries such as ``{“user”: “f4a”}``. A central dictionary of existing key names which is accessible and modifiable by all developers may help to ensure consistency.

**Make it easy to distinguish between events happening at different points in the system, but at the same time.**
  This can be done by adding entries for hosts, processes, threads, etc. to log messages.

**Provide as much context as possible.**
  Treat each log message as a message about an event. All context necessary to understand the event should be present in the log message. Long log messages with many parameters are not an issue if they are well-structured, allowing for easy filtering of information relevant to the current analysis. Logging the class and function in which the event took place may be helpful.

  At the time of development, most likely you will not be able to think of all possible questions someone might want to answer with the help of the log files written by your application. Consequently, providing as much information as possible may prove helpful in the future.

**Severity levels have limited use in complex systems.**
  An upstream event may not be critical for the component in which it takes place, but may cause problems in a component further downstream. The downstream component may not be known to the developer of the upstream component, so choosing appropriate severity levels for all situations is not possible.

**Use fine-grained timestamps with time zones.**
  A granularity of at least milliseconds ensures the correct order of events happening in fast succession can be reconstructed. Time zone information is essential in distributed systems where individual components may be located on different continents.

Home automation
===============

Use case description
--------------------

Measured values from the residential area of tenants or house owners are to be automatically made available in third-party software. This increases the comfort of use. The user receives more information as a basis for decision-making on his supply contracts and consumption behaviour.
 
To implement this connection, the user employs a gateway that collects the measured values and transmits them via a defined interface to a platform derived from Flex4Apps components.

Best practices
--------------

**Prefer industry standard over individual.**
  Use-case home automation is characterized by a multitude of manufacturer-specific and self-contained solutions. In the course of the project it became clear that trust in such an individual standard can be disappointed. 

  Only through the consistent use of open interfaces and basic products can the dependency on individual providers and their business models be avoided. This enables solutions which work better in a very volatile environment and which can be quickly adapted to new circumstances.

**Consider the overhead caused by addressing and encryption. Limited bandwidth can limit use case.**
  Standard encryption procedures produce a little data overhead. This can be too much depending on the available throughput to the used media.

  This became relevant in the attempt to set up in-house communication on an existing proprietary system solution. While the transmission of user data was just possible, encryption of this data was too much for the medium.

  When estimating the required transmission capacity, it is therefore essential to consider the overhead caused by addressing and encryption.

**Use MQTT as central transport layer.**
  MQTT is widely used and accepted as a vendor-neutral transmission protocol. Consequently, employing MQTT enables the quick integration of new data sources from third parties.

